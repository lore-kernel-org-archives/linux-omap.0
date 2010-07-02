From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [RFC 1/7] OMAP: Introduce a user list for each voltage domain
 instance in the voltage driver.
Date: Fri, 2 Jul 2010 17:14:23 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305B05DA8@dbde02.ent.ti.com>
References: <1278065909-32148-1-git-send-email-thara@ti.com>
 <1278065909-32148-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50142 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756973Ab0GBLpy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 07:45:54 -0400
In-Reply-To: <1278065909-32148-2-git-send-email-thara@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Thara,

> -----Original Message-----
> From: Gopinath, Thara
> Sent: Friday, July 02, 2010 3:48 PM
> To: linux-omap@vger.kernel.org
> Cc: khilman@deeprootsystems.com; paul@pwsan.com; Cousson, Benoit; Sripathy,
> Vishwanath; Sawant, Anand; Basak, Partha; Gopinath, Thara
> Subject: [RFC 1/7] OMAP: Introduce a user list for each voltage domain instance in
> the voltage driver.
> 
> This patch introduces a user list of devices associated with each
> voltage domain instance. The user list is implemented using plist
> structure with priority node populated with the voltage values.
> This patch also adds an API which will take in a device and
> requested voltage as parameters, adds the info to the user list
> and returns back the maximum voltage requested by all the user
> devices. This can be used anytime to get the voltage that the
> voltage domain instance can be transitioned into.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/voltage.c             |   83
> +++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/voltage.h |    2 +
>  2 files changed, 85 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 30f1770..a2f30a4 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -24,6 +24,9 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/debugfs.h>
> +#include <linux/spinlock.h>
> +#include <linux/plist.h>
> +#include <linux/slab.h>
> 
>  #include <plat/omap-pm.h>
>  #include <plat/omap34xx.h>
> @@ -93,6 +96,20 @@ struct vp_reg_val {
>  };
> 
>  /**
> + * omap_vdd_user_list	- The per vdd user list
> + *
> + * @dev		: The device asking for the vdd to be set at a particular
> + *		  voltage
> + * @node	: The list head entry
> + * @volt	: The voltage requested by the device <dev>
> + */
> +struct omap_vdd_user_list {
> +	struct device *dev;
> +	struct plist_node node;
> +	u32 volt;
> +};
> +
> +/**
>   * omap_vdd_info - Per Voltage Domain info
>   *
>   * @volt_data		: voltage table having the distinct voltages supported
> @@ -103,6 +120,9 @@ struct vp_reg_val {
>   *			  vp registers
>   * @volt_clk		: the clock associated with the vdd.
>   * @opp_dev		: the 'struct device' associated with this vdd.
> + * @user_lock		: the lock to be used by the plist user_list
> + * @user_list		: the list head maintaining the various users
> + *			  of this vdd with the voltage requested by each user.
>   * @volt_data_count	: Number of distinct voltages supported by this vdd.
>   * @nominal_volt	: Nominal voltaged for this vdd.
>   * cmdval_reg		: Voltage controller cmdval register.
> @@ -115,6 +135,8 @@ struct omap_vdd_info{
>  	struct clk *volt_clk;
>  	struct device *opp_dev;
>  	struct omap_volt_domain volt_domain;
> +	spinlock_t user_lock;
> +	struct plist_head user_list;
>  	int volt_data_count;
>  	unsigned long nominal_volt;
>  	u8 cmdval_reg;
> @@ -361,6 +383,10 @@ static void __init omap3_vdd_data_configure(struct
> omap_vdd_info *vdd)
>  	struct clk *sys_ck;
>  	u32 sys_clk_speed, timeout_val, waittime;
> 
> +	/* Init the plist */
> +	spin_lock_init(&vdd->user_lock);
> +	plist_head_init(&vdd->user_list, &vdd->user_lock);
> +
>  	if (!strcmp(vdd->volt_domain.name, "mpu")) {
>  		if (cpu_is_omap3630()) {
>  			vdd->vp_reg.vlimitto_vddmin =
> @@ -881,6 +907,63 @@ unsigned long omap_voltageprocessor_get_curr_volt(
>  }
> 
>  /**
> + * omap_voltage_get_final : API to keep track of various requests to
[minor] This name does not match the actual API
> + *			    scale the VDD and returns the best possible
> + *			    voltage the VDD can be put to.
> + * @volt_domain: pointer to the voltage domain.
> + * @dev : the device pointer.
> + * @volt : the voltage which is requested by the device.
> + *
> + * This API is to be called before the actual voltage scaling is
> + * done to determine what is the best possible voltage the VDD can
> + * be put to. This API adds the device <dev> in the user list of the
> + * vdd <volt_domain> with <volt> as the requested voltage. The user list
> + * is a plist with the priority element absolute voltage values.
> + * The API then finds the maximum of all the requested voltages for
> + * the VDD and returns it back through <volt> pointer itself.
> + * Returns error value in case of any errors.
> + */
> +int omap_volt_get_final(struct omap_volt_domain *volt_domain,
> +		struct device *dev, unsigned long *volt)
> +{
> +	struct omap_vdd_info *vdd;
> +	struct omap_vdd_user_list *user;
> +	struct plist_node *node;
> +	int found = 0;
> +
> +	if (!volt_domain || IS_ERR(volt_domain)) {
> +		pr_warning("%s: VDD specified does not exist!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	vdd = container_of(volt_domain, struct omap_vdd_info, volt_domain);
> +
> +	plist_for_each_entry(user, &vdd->user_list, node) {
> +		if (user->dev == dev) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		user = kzalloc(sizeof(struct omap_vdd_user_list), GFP_KERNEL);
> +		if (!user) {
> +			pr_err("%s: Unable to creat a new user for vdd_%s\n",
> +				__func__, volt_domain->name);
> +			return -ENOMEM;
> +		}
> +		user->dev = dev;
> +		plist_node_init(&user->node, *volt);
> +		plist_add(&user->node, &vdd->user_list);
> +	}
> +
> +	user->node.prio = *volt;
> +	node = plist_first(&vdd->user_list);
> +	*volt = node->prio;
> +	return 0;
Shouldn't this function be protected using a mutex_lock/semaphore? It's possible that just after you are done with plist search, some other thread might get scheduled and try to add the same user.
> +}
> +
> +/**
>   * omap_voltageprocessor_enable : API to enable a particular VP
>   * @volt_domain: pointer to the VDD whose VP is to be enabled.
>   *
> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-
> omap/include/plat/voltage.h
> index b7ac318..bc1e4d3 100644
> --- a/arch/arm/plat-omap/include/plat/voltage.h
> +++ b/arch/arm/plat-omap/include/plat/voltage.h
> @@ -128,6 +128,8 @@ int omap_get_voltage_table(struct omap_volt_domain
> *volt_domain,
>  struct omap_volt_data *omap_get_volt_data(
>  		struct omap_volt_domain *volt_domain, unsigned long volt);
>  unsigned long get_curr_voltage(struct omap_volt_domain *volt_domain);
> +int omap_volt_get_final(struct omap_volt_domain *volt_domain,
> +		struct device *dev, unsigned long *volt);
>  #ifdef CONFIG_PM
>  void omap_voltage_init_vc(struct omap_volt_vc_data *setup_vc);
>  #else
> --
> 1.7.0.rc1.33.g07cf0f

