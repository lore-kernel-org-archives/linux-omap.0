From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V3 05/19] OMAP3+: voltage: use IS_ERR_OR_NULL
Date: Sun, 6 Mar 2011 08:18:40 +0000
Message-ID: <20110306081840.GB2400@n2100.arm.linux.org.uk>
References: <1299338962-5602-1-git-send-email-nm@ti.com> <1299338962-5602-6-git-send-email-nm@ti.com> <AANLkTi=q_ASfvLbZv=D8p3XvuMX8ek3hcEHU5wtfkm7J@mail.gmail.com> <4D72F532.3020909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44660 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab1CFITA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Mar 2011 03:19:00 -0500
Content-Disposition: inline
In-Reply-To: <4D72F532.3020909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: David Cohen <dacohen@gmail.com>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Sun, Mar 06, 2011 at 08:15:06AM +0530, Nishanth Menon wrote:
> my_dumb_func(){
> 	struct voltagedomain *vdata = NULL;
> 	if (cpu_is_omap3630()_) {
> 		vdata = omap_voltage_domain_lookup("mpu")
> 	}
> 	/* forgot to add other cpu types or a else case */
> 	/* do other things */
> 	me_volt=omap_voltage_get_nom_volt(vdata);
> 	/* do things with me_volt */
> }
>
> Sorry, but i think the check, even if seems superfluous is sane IMHO.  
> even if the above code worked on 3630, it'd fail on o4/3430 without the  
> check, it can even crash. and given that we've all seen our fair share  
> of developers who develop for one platform without consideration that  
> the rest of the world uses others as well... I do feel cases like above  
> example might infact be a reality.

But normal practice is to check the return value from functions before
it's used.  So:

 my_dumb_func(){
	struct voltagedomain *vdata = NULL;
	if (cpu_is_omap3630()) {
		vdata = omap_voltage_domain_lookup("mpu")
	}
	/* forgot to add other cpu types or a else case */

+	if (!vdata)
+		return some error;

	/* do other things */
	me_volt=omap_voltage_get_nom_volt(vdata);
	/* do things with me_volt */
 }

is the right way to deal with this.  Pushing the primary error checking
down into sub-functions is stupid - where does it stop?  Do you check
me_volt for errors?  Do you get functions which use me_volt to check for
errors from that too?

It's a silly idea.  Put the primary error checking in the function which
gets the return value.  Don't bury it in sub-functions.
