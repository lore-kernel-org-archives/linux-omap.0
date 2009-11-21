From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH 2/9 v2] omap3: pm: introduce opp accessor functions
Date: Sat, 21 Nov 2009 17:07:08 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9DE207167@dnce01.ent.ti.com>
References: <1258092322-30833-1-git-send-email-nm@ti.com><1258092322-30833-2-git-send-email-nm@ti.com><1258092322-30833-3-git-send-email-nm@ti.com><87vdhdncqz.fsf@deeprootsystems.com>
 <4B001640.5070405@ti.com><4B036526.6070500@ti.com>
 <87pr7e6kxc.fsf@deeprootsystems.com> <4B05FBE1.6010708@ti.com>
 <4B0757E7.9020706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45942 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbZKUQHN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Nov 2009 11:07:13 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <4B0757E7.9020706@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Lam, SuiLun" <s-lam@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Hi Nishanth,

> From: Menon, Nishanth
> Sent: Saturday, November 21, 2009 4:01 AM

[...]

> /**
>   * struct omap_opp_def - OMAP OPP Definition
>   * @enabled: True/false - is this OPP enabled/disabled by default
>   * @freq:    Frequency in hertz corresponding to this OPP
>   * @m_volt:  Nominal voltage in millivolts corresponding to this OPP
>   *
>   * OMAP SOCs from OMAP3 onwards have a standard set of tuples consisting
>   * of frequency and voltage pairs that the device will support. This is
>   * Operating Point. However, the actual definitions of OMAP Operating
> Point
>   * varies over silicon within the same family of devices. For a specific
>   * domain, you can have a set of {frequency, voltage} pairs and this is
> denoted
>   * by an array of omap_opp_def. As the kernel boots and more information

The OPP term is not necessarily something new to OMAP3; OMAP2420/2430 already supported 2 OPPs (100% and 50%) and to some extend OMAP1610/1710 were also able to run at a lowest OPP (50%).

To be more accurate, you should explain that the OPP is relative to a voltage domain and that all IPs in that voltage domain will have potentially their own OPPs depending of the voltage.

> is
>   * available, a set of these are activated based on the precise nature of
>   * device the kernel boots up on.
>   *
>   * NOTE: A disabled opp from the omap_opp_def table may be enabled as
> part of

Are you sure you want to allow that? What if you re-enable none supported OPPs like a speed-binning OPP on a regular device?

>   * runtime logic. It is discouraged to enable/disable the OPP unless
> they are
>   * done as part of OPP registration sequence.

Why is it discouraged? We should have as well the capability to enable/disable dynamically and temporarily an OPP (thermal management, frequency avoidance, select different OPP sets...).

You should differentiate OPPs disabled at boot time because they are not supported by the platform and the ones disabled at runtime. It will avoid that you potentially re-enable a forbidden OPP.

Why don't you remove them during the opp_init phase?

>   */
> struct omap_opp_def {
>       bool enabled;
>       unsigned long freq;
>       u16 m_volt;

It might be better to use an u32 and store the voltage in microvolt considering that the T2 and Phoenix have a 12.5 mV accuracy step. Moreover, this is what the regulator framework is currently using, it will avoid the *1000 operation, which is not that a big deal, I agree...

> };
>
> /**
>   * opp_init - Initialize an OPP table from the initial table definition
>   * @oppl:    Returned back to caller as the opp list to reference the OPP
>   * @opp_defs:        Array of omap_opp_def to describe the OPP. This list
> should be
>   *           0 terminated.
>   *
>   * This function creates the internal datastructure representing the
> OPP list
>   * from an initial definition table. this handle is then used for further
>   * validation, search, modification operations on the OPP list.
>   *
>   * This function returns 0 and the pointer to the allocated list
> through oppl if
>   * success, else corresponding error value. Caller should NOT free the
> oppl.
>   * opps_defs can be freed after use.
>   */
> int opp_init(struct omap_opp **oppl, const struct omap_opp_def *opp_defs);
>
> /**
>   * opp_enable - Enable or disable a specific OPP

You'd better provide two APIs opp_enable and opp_disable or find a better name for that one, like opp_state or opp_set_state.

>   * @opp:     pointer to opp
>   * @freq:    frequency in hertz
>   * @enable:  true/false to enable/disable that specific OPP
>   *
>   * Enables/disables a provided freq in the opp list. If the operation
> is valid,
>   * this returns 0, else the corresponding error value.
>   *
>   * OPP used here is from the the opp_is_valid/opp_has_freq or other
> search
>   * functions
>   */
> int opp_enable(const struct omap_opp *opp, const unsigned int freq);
>
> #endif                /* __ASM_ARM_OMAP_OPP_H */
>

Regards,
Benoit

Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



