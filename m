From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dmaengine: edma: Remove dynamic TPTC power management
 feature
Date: Thu, 28 Jan 2016 11:00:50 +0200
Message-ID: <56A9D8C2.7000401@ti.com>
References: <1453885906-17652-1-git-send-email-peter.ujfalusi@ti.com>
 <20160127155422.GH19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160127155422.GH19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On 01/27/2016 05:54 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160127 01:12]:
>> The dynamic or on demand pm_runtime does not work correctly on am335=
x and
>> am437x due to interference with hwmod.
>=20
> Hmm care expand a bit what is the problem with this "interference"?

The idea was to enable/power on only the TPTCs which is actually in use=
 and
leave the unused ones off. Which is is nice and all, but...
The original implementation did the pm_runtime calls for the tptcs from=
 the
edma tpcc driver instance and the main issue was that I did the pm_runt=
ime
calls in the edma-tpcc pm callbacks as well.
Since omap hwmod/device also handles pm_runtime on behalf of the driver=
s we
got nasty issues, kernel crash, warnings on suspend/resume.

Then I did implemented the on demand power management in a totally diff=
erent
way, still keeping only tptcs enabled which is in use.
In this way all the omap hwmod/device incoherency was gone and things l=
ooked
fine, but it turned out that on second suspend we are not able to wake =
up the
board.
I and Tero debugged this a bit and it turns out that we need to kepp al=
l tptcs
enabled and powered, otherwise the HW will not going to be able to comp=
lete
the transition, breaking suspend/resume.

With pm_runtime_enable() + get_sync() on all tptcs we can suspend and r=
esume
w/o problems and they will be disabled/enabled by omap hwmod/device cod=
e,
following nicely the power state of the system.

As a note: I did tried the suspend/resume with the old code with dra7, =
but it
turned out that on dra7 SW has no control over the tptc power state, it
follows the system in HW.

In short: The implementation was flawed and even if the implementation =
is
correct the HW will lock up if we do on demand tptc power management.

--=20
P=E9ter
