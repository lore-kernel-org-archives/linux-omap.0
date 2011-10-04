From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 0/5 v12] mfd: omap: usb: Runtime PM support for EHCI and
 OHCI drivers
Date: Tue, 4 Oct 2011 17:24:23 +0530
Message-ID: <CAP05o4+AQee0dJdiU9gaTcSh6vMX=qRd9prtqPN_n=SpW-cWgQ@mail.gmail.com>
References: <1317306247-1103-1-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1109301259570.12185@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1109301259570.12185@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

On Sat, Oct 1, 2011 at 12:31 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hi Keshava,
>
> by the way, when you repost these, can you split this into two series=
 --
> one for the arch/arm/*omap* changes, and the other for changes that s=
hould
> go in through the MFD tree? =A0Then just note in the second series th=
at it
> has a dependency on the first. =A0That will make it easier to merge t=
hese
> patches, and should cut down on the number of cc's that are necessary=
 for
> most of these patches.

so, only patch 5 will be out this existing series;
1-4 will be one series and only patch 5 will be sent as a separate patc=
h.

regards
keshava
