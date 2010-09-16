From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 01/13] OMAP: Introduce a user list for each voltage
 domain instance in the voltage driver.
Date: Thu, 16 Sep 2010 15:29:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03294424BB@dbde02.ent.ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-2-git-send-email-thara@ti.com>
 <87iq2vipe7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43547 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753453Ab0IPJ7K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 05:59:10 -0400
In-Reply-To: <87iq2vipe7.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Saturday, August 28, 2010 5:23 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Sripathy, Vishwanath; Sawant, Anand; Cousson, Benoit
>>Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain instance in the
>>voltage driver.
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch introduces a user list of devices associated with each
>>> voltage domain instance. The user list is implemented using plist
>>> structure with priority node populated with the voltage values.
>>> This patch also adds an API which will take in a device and
>>> requested voltage as parameters, adds the info to the user list
>>> and returns back the maximum voltage requested by all the user
>>> devices. This can be used anytime to get the voltage that the
>>> voltage domain instance can be transitioned into.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/voltage.c             |   94 +++++++++++++++++++++++++++++
>>>  arch/arm/plat-omap/include/plat/voltage.h |    2 +
>>>  2 files changed, 96 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
>>> index 6a07fe9..4624250 100644
>>> --- a/arch/arm/mach-omap2/voltage.c
>>> +++ b/arch/arm/mach-omap2/voltage.c
>>> @@ -24,6 +24,9 @@
>>>  #include <linux/clk.h>
>>>  #include <linux/err.h>
>>>  #include <linux/debugfs.h>
>>> +#include <linux/spinlock.h>
>>> +#include <linux/plist.h>
>>> +#include <linux/slab.h>
>>>
>>>  #include <plat/omap-pm.h>
>>>  #include <plat/omap34xx.h>
>>> @@ -95,6 +98,20 @@ struct vp_reg_val {
>>>  };
>>>
>>>  /**
>>> + * omap_vdd_user_list	- The per vdd user list
>>> + *
>>> + * @dev		: The device asking for the vdd to be set at a particular
>>> + *		  voltage
>>> + * @node	: The list head entry
>>> + * @volt	: The voltage requested by the device <dev>
>>> + */
>>> +struct omap_vdd_user_list {
>>> +	struct device *dev;
>>> +	struct plist_node node;
>>> +	u32 volt;
>>> +};
>>> +
>>> +/**
>>>   * omap_vdd_info - Per Voltage Domain info
>>>   *
>>>   * @volt_data		: voltage table having the distinct voltages supported
>>> @@ -105,6 +122,9 @@ struct vp_reg_val {
>>>   *			  vp registers
>>>   * @volt_clk		: the clock associated with the vdd.
>>>   * @opp_dev		: the 'struct device' associated with this vdd.
>>> + * @user_lock		: the lock to be used by the plist user_list
>>> + * @user_list		: the list head maintaining the various users
>>> + *			  of this vdd with the voltage requested by each user.
>>>   * @volt_data_count	: Number of distinct voltages supported by this vdd.
>>>   * @nominal_volt	: Nominal voltaged for this vdd.
>>>   * cmdval_reg		: Voltage controller cmdval register.
>>> @@ -117,6 +137,9 @@ struct omap_vdd_info{
>>>  	struct clk *volt_clk;
>>>  	struct device *opp_dev;
>>>  	struct voltagedomain voltdm;
>>> +	spinlock_t user_lock;
>>> +	struct plist_head user_list;
>>> +	struct mutex scaling_mutex;
>>>  	int volt_data_count;
>>>  	unsigned long nominal_volt;
>>>  	u8 cmdval_reg;
>>> @@ -785,11 +808,18 @@ static void __init vdd_data_configure(struct omap_vdd_info *vdd)
>>>  	struct dentry *vdd_debug;
>>>  	char name[16];
>>>  #endif
>>> +
>>>  	if (cpu_is_omap34xx())
>>>  		omap3_vdd_data_configure(vdd);
>>>  	else if (cpu_is_omap44xx())
>>>  		omap4_vdd_data_configure(vdd);
>>>
>>> +	/* Init the plist */
>>> +	spin_lock_init(&vdd->user_lock);
>>> +	plist_head_init(&vdd->user_list, &vdd->user_lock);
>>> +	/* Init the DVFS mutex */
>>> +	mutex_init(&vdd->scaling_mutex);
>>> +
>>>  #ifdef CONFIG_PM_DEBUG
>>>  	strcpy(name, "vdd_");
>>>  	strcat(name, vdd->voltdm.name);
>>> @@ -1142,6 +1172,70 @@ unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm)
>>>  }
>>>
>>>  /**
>>> + * omap_voltage_add_userreq : API to keep track of various requests to
>>> + *			    scale the VDD and returns the best possible
>>> + *			    voltage the VDD can be put to.
>>> + * @volt_domain: pointer to the voltage domain.
>>> + * @dev : the device pointer.
>>> + * @volt : the voltage which is requested by the device.
>>> + *
>>> + * This API is to be called before the actual voltage scaling is
>>> + * done to determine what is the best possible voltage the VDD can
>>> + * be put to. This API adds the device <dev> in the user list of the
>>> + * vdd <volt_domain> with <volt> as the requested voltage. The user list
>>> + * is a plist with the priority element absolute voltage values.
>>> + * The API then finds the maximum of all the requested voltages for
>>> + * the VDD and returns it back through <volt> pointer itself.
>>> + * Returns error value in case of any errors.
>>> + */
>>> +int omap_voltage_add_userreq(struct voltagedomain *voltdm, struct device *dev,
>>> +		unsigned long *volt)
>>
>>How about just omap_voltage_add_request()
>>
>>Also, do we need both voltdm and dev?  With your other patches, can't we
>>look up the voltm based on dev?  Or, is there a need for a device to add
>>a request in a voltage domain other than the one to which it belongs?
>>
>>Also, how does one remove a voltage request?

Hello Kevin,

I could rename this API to what you have suggested. Yes we do need voltdm and dev.
Let us say I have three devices in a voltdm and I need to maintain a request for each
of these devices.

When a omap_device_set_rate API is called by the device to lower its rate the voltage
request will automatically get lowered.

>>
>>> +{
>>> +	struct omap_vdd_info *vdd;
>>> +	struct omap_vdd_user_list *user;
>>> +	struct plist_node *node;
>>> +	int found = 0;
>>> +
>>> +	if (!voltdm || IS_ERR(voltdm)) {
>>> +		pr_warning("%s: VDD specified does not exist!\n", __func__);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
>>> +
>>> +	mutex_lock(&vdd->scaling_mutex);
>>> +
>>> +	plist_for_each_entry(user, &vdd->user_list, node) {
>>> +		if (user->dev == dev) {
>>> +			found = 1;
>>> +			break;
>>> +		}
>>> +	}
>>
>>Minor: I'm not crazy about the 'found' flag.  IMO, readability is
>>improved if you init 'user = NULL' above, use a tmp pointer to
>>walk the list, and rather than 'found = 1', do 'user = tmp_user'
>>when you find the match.

Ok will do.

>>
>>> +
>>> +	if (!found) {
>>
>>and here, do if (!user)
>>
>>> +		user = kzalloc(sizeof(struct omap_vdd_user_list), GFP_KERNEL);
>>> +		if (!user) {
>>> +			pr_err("%s: Unable to creat a new user for vdd_%s\n",
>>> +				__func__, voltdm->name);
>>> +			mutex_unlock(&vdd->scaling_mutex);
>>> +			return -ENOMEM;
>>> +		}
>>> +		user->dev = dev;
>>> +	} else {
>>> +		plist_del(&user->node, &vdd->user_list);
>>
>>hmm... if we get here, we didn't find a match, so 'user' points to the
>>last element in the list (which is the highest voltage request, I
>>guess), or even NULL if the list is empty.  Then, this node is deleted.
>>
>>-ECONFUSED

I do not understand this comment. But I will surely look into this part of code.
Btw this code is now more tested out with OMAP4 internally.

>>
>>> +	}
>>> +
>>> +	plist_node_init(&user->node, *volt);
>>> +	plist_add(&user->node, &vdd->user_list);
>>> +	node = plist_first(&vdd->user_list);
>>> +	*volt = node->prio;
>>> +
>>> +	mutex_unlock(&vdd->scaling_mutex);
>>> +
>>> +	return 0;
>>> +}
>>
>>Can't think of a use-case now (cuz it's Friday), but would we ever want
>>to add multiple requests per device?
>>
>>The current approch will only track one request per device.
IMHO only as of now only one request per device needs to be tracked. A device the volt
domain to be at only one particular voltage at any instance. 

Regards
Thara
