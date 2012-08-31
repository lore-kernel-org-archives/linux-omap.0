From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP HWMOD: Query regarding parent<->child support
Date: Fri, 31 Aug 2012 10:47:35 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA9E5A3@DBDE01.ent.ti.com>
References: <5004212C.5030807@ti.com> <502E1914.3050502@ti.com>
 <502E397E.50904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47481 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539Ab2HaKrl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 06:47:41 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, "N, Mugunthan V" <mugunthanvnm@ti.com>, "Philip, Avinash" <avinashphilip@ti.com>, Tony Lindgren <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Hilman, Kevin" <khilman@ti.com>

On Fri, Aug 24, 2012 at 21:21:45, Hiremath, Vaibhav wrote:
> On Fri, Aug 17, 2012 at 18:00:54, Cousson, Benoit wrote:
> > Hi Vaibhav,
> > 
> > On 08/17/2012 12:12 PM, Vaibhav Hiremath wrote:
> > > 
> > > 
> > > On 7/16/2012 7:41 PM, Vaibhav Hiremath wrote:
> > >> Hi All,
> > >>
> > > 
> > > Paul,
> > > 
> > > From last couple of days I am almost spending my whole time trying to
> > > get to somewhere on below issue and based on my understanding and
> > > learning so far I started feeling that, probably we might have made
> > > wrong decision to remove all leaf-nodes from the clock-tree. Instead we
> > > should have it removed from hwmod. :)
> > > 
> > > Let's take a example of PWM Module (which is the context of my debugging) -
> > > 
> > > As I mentioned before, PWM module present in AM33XX looks something like -
> > > 
> > > 
> > >     ----------------------------------
> > >    |            --------              |
> > >    |           |  PWMSS |             |
> > >    |            --------              |
> > >    |  -------   --------   ---------  |
> > >    | |  eCAP | |  ePWM  | |  eQEP   | |
> > >    |  -------   --------   ---------  |
> > >     ----------------------------------
> > > 
> > > PWMSS: This actually controls all PM related signals like idle,
> > >        standby, etc...
> > > eCAP/ePWM/eQEP: Technically it is independent module, reused from
> > >                 Davinci devices and is implemented as independent
> > >                 drivers in kernel.
> > > 
> > > In case of AM33xx, the basic resources like, clock, idle signal and
> > > standby signal are abstracted at PWMSS level.
> > > This means the core IP (eCAP/ePWM/eQEP) have not changed from their
> > > original implementation.
> > > 
> > > These core IP's (eCAP/ePWM/eQEP) are being used in Davinci family of
> > > devices, but without encapsulation of PWMSS, unlike AM33XX. This means,
> > > each module has its own clock enable/disable control mechanism and there
> > > is no dependency between them, unlike AM33XX.
> > > 
> > > Options to support:
> > > 
> > > 1. Use existing Clock Framework infrastructure to handle, which
> > > basically supports clock enable/disable function based on usecount and
> > > parent<->child relation. Driver will simply work, without knowing
> > > anything about underneath platform, which is what expected.
> > > So create a dummy-clocks for submodules, making PWMSS clock as a parent
> > > will solve the issue here.
> > > 
> > > And nothing wrong here, we are just treating,
> > >    clock-enable = module-enable
> > 
> > Yeah, but that looks like a hack to me. That clock hierarchy does not
> > exist for real and the pm_runtime infrastructure can handle that
> > properly. In that case you do have a PM dependency and not necessarily a
> > clock dependency.
> > 
> 
> In one sense, yes.
> 
> > > The only issue here is sysconf register access at hwmod level, if you
> > > leave sysconf idle and standby configuration at smart state, it works
> > > properly. I have validated it at my end.
> > > 
> > > 2. MFD Driver: I think it will be miss-use of MFD driver and should be
> > > explored at all.
> > 
> > I do think this is the proper use of MFD. 
> 
> Not certainly, as I said, here we are trying to solve some weird SoC 
> integration dependency and will not work across devices, like Davinci.
> 
> > In fact with DT, you don't
> > even need an MFD. The DT nodes hierarchy will create the parent-child
> > link automatically.
> > 
> > pm_runtime events are taking care of the parent state. It means that if
> > you are enabling a child, the parent will be enabled first automatically
> > by the PM fmwk.
> > 
> 
> Fortunately before going on vacation last week I attempted this and found 
> some issues - 
> 
> What I did was,
> 
> 	ehrpwmss0: ehrpwmss0@48300000 {
> 		compatible      = "ti,ehrpwmss";
> 		ti,hwmods = "ehrpwmss0";
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		ranges;
> 
> 		ehrpwm0: ehrpwm@48300200 {
> 			compatible      = "ti,ehrpwm";
> 			ti,hwmods = "ehrpwm0";
> 			#pwm-cells = <3>;
> 			has_configspace = <1>;
> 		};
> 
> 		ecap0: ecap@48300100 {
> 			compatible      = "ti,ecap";
> 			ti,hwmods = "ecap0";
> 			#pwm-cells = <3>;
> 			has_configspace = <1>;
> 		};
> 	};
> 
> Above DT implementation created device nodes like,
> 
> 	ehrpwmss0 (no Linux driver) ->
> 		-> ehrpwm0 (driver/pwm/ehrpwm.c)
> 		-> ecap0 (drivers/pwm/ecap.c)
> 
> Please note that, we do not have any driver code available for parent 
> device, as it is AM33XX specific and we don't want eCAP and eHRPWM drivers 
> should know about it.
> 
> The runtime_pm api's implementation is based on "disable_depth", and it 
> works something like,
> 
> Driver ->
> 	Pm_runtime_enable() -> decrement "disable_depth"
> 		-> pm_runtime_get_sync() -> Check for "disable_depth" and if
>                It is 0 then call reached platform code.
> 
> Now somebody has to call pm_runtime_enable() function for parent device,
> which I believe is our problem area here.
> 
> Please note that, I have actually changed code to see whether it is really possible, so please let me know if you have any suggestions which I can try
> on board.
> 
> > This is how the DSS will/was be modified to handle the similar issue you
> > are facing today. I'm not sure that code is upstream yet, but was tested
> > on OMAP5.
> > 
> 
> DSS is not comparable with AM33XX PWM use-case, as dss-core file is present 
> and available always, which does runtime_pm calls.
> 
> > The only drawback in your case is that the Davinci drivers must be
> > pm_runtime adapted, which might not be the case already :-(.
> > 
> 
> I believe it is already done, I have seen Sekhar submitted patches for this.
> Having said that, it may not be relevant to our discussion, as explained 
> above.
> 

Benoit,

Any further comment on this thread??

Thanks,
Vaibhav
