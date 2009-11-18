From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/9 v2] omap3: pm: introduce opp accessor functions
Date: Tue, 17 Nov 2009 21:08:22 -0600
Message-ID: <4B036526.6070500@ti.com>
References: <1258092322-30833-1-git-send-email-nm@ti.com>	<1258092322-30833-2-git-send-email-nm@ti.com>	<1258092322-30833-3-git-send-email-nm@ti.com> <87vdhdncqz.fsf@deeprootsystems.com> <4B001640.5070405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49049 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753572AbZKRDIU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Nov 2009 22:08:20 -0500
In-Reply-To: <4B001640.5070405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Lam, SuiLun" <s-lam@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Menon, Nishanth had written, on 11/15/2009 08:54 AM, the following:
[...]
> b) Improvements of the omap accessor functions, I will send out few of
> the proposals I can think of later when I get some free time.. we can
> discuss that too.
Here is my initial proposal, do feel free to comment/add/modify etc:

In the accessor functions listed here, I have followed:
a) The function will return 0 if success else appropriate error values, 
all values are passed by pointer params.
b) Overall, the idea is to transition from exposing omap_opp to users 
currently to a system where opp handling logic will be blackboxed from 
the rest of the system - giving us options to optimize and scale 
internal logic and storage mechanism without impacting the rest of the 
system.
c) resultant code should be readable - this is one of the issues I see 
with my previous implementation.

Files: Introduce opp.c and opp.h

A) Data Structures:
Interim:
opp.h
struct omap_opp {
	bool enabled;
	unsigned long rate; /* in hz */
	u8 opp_id; /* int */
	u16 vsel; /* T2 voltage value */
};
typedef struct omap_opp omap_opp_def;

Final, once resource34xx.c and all direct accesses are cleaned up:

opp.h:
struct omap_opp;

/* initial definitions of OPP, will be used by all */
struct omap_opp_def {
	bool enabled; /* true/false */
	unsigned long rate; /* in hz */
	u16 vsel; /* in millivolts */
};

opp.c:
struct omap_opp {
	bool enabled;
	unsigned long rate;
	u16 vsel;
};

or what ever implementation it needs. can be array, list, hash 
implementation or what ever we choose it to be.

B) Accessor functions to be used:

B.1) These functions should be removed once SRF is replaced/cleaned up:

int opp_id_to_freq(unsigned long *freq, const struct omap_opp *opps, u8 
opp_id);
int opp_freq_to_id(u8 *opp_id, const struct omap_opp *opps, unsigned 
long freq);


B.2) initialization functions:

/* Register the OPP list for the silicon */
int opp_register(struct omap_opp *opp_list,
		 const struct omap_opp_def *opp_reg);


/* Enable a specific frequency */
int opp_enable(struct omap_opp *opp_list,
		unsigned long freq, bool enable);

Users:
opp_register will be called by pm34xx.c based on silicon type.
opp_enable will be called by board file/ has_feature based logic etc.. 
on a need basis

B.3) verification functions:

/* Check if we have a  frequency in the list(enabled/disabled)
  * this is needed by users who would like to enable a disabled
  * frequency
  */
int opp_has_freq(struct omap_opp *opp_list, unsigned long freq);

/* Check if we have a enabled frequency - this is what most users
  * will need
  */
int opp_is_freq_valid(struct omap_opp *opp_list, unsigned long freq);

Users:
	files who'd want to use opp_enable,
	validation paths.

B.4) Limit functions:

/* To get a number of frequencies enabled */
int opp_get_freq_count(const struct omap_opp *opp_list, u8 *num);

/* Get highest enabled frequency */
int opp_get_highest_freq(struct omap_opp *opp_list,
	unsigned long *freq);

/* Get lowest enabled frequency */
int opp_get_lowest_freq(struct omap_opp *opp_list, unsigned long *freq);

Users:
	Obvious user is the current cpufreq

B.5) Search functions -> these will check only enabled frequencies. This 
will not check if the start freq provided in *freq is an enabled 
frequency or not. Assumption I am making is: if you are searching for a 
frequency that is disabled in the opp list, you are not trying something 
generic -hence wont support.

/* Get higher enabled frequency than the provided one */
int opp_get_higher_freq(struct omap_opp *opp_list, unsigned long *freq);

/* Get lower enabled frequency than the provided one */
int opp_get_lower_freq(struct omap_opp *opp_list, unsigned long *freq);

Users:
	current srf, future scale logic

B.6) voltage functions - opp layer will not trigger voltage transition, 
it is upto other users of opp layer to make a decision.

/* get voltage corresponding to a frequency */
int opp_freq_to_voltage(u16 *voltage, struct omap_opp *opp_list,
			unsigned long *freq);

Users:
	current SR/SRF, future voltage framework.

-- 
Regards,
Nishanth Menon

