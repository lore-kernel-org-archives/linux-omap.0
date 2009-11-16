From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: linux-next: manual merge of the omap_dss2 tree with the omap
 tree
Date: Mon, 16 Nov 2009 12:06:41 +0200
Message-ID: <1258366001.2384.25.camel@tubuntu.research.nokia.com>
References: <20091116160402.deb0cc82.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20091116160402.deb0cc82.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-omap@vger.kernel.org

On Mon, 2009-11-16 at 06:04 +0100, ext Stephen Rothwell wrote:
> Hi Tomi,
> 
> Today's linux-next merge of the omap_dss2 tree got a conflict in
> arch/arm/configs/omap_3430sdp_defconfig between the omap tree and the
> omap_dss2 tree.
> 
> I just used the version from the omap tree as I can't figure out anything
> better, sorry.

Tony, 

These patches in omap tree seem to cause the conflicts. Are they stable,
ie. can I cherry pick them to my for-next tree, and put my patches on
top of them?

b30dcf5f37023d591caee80c233bf33706bc5a21
omap3: 3430sdp: Enable Linux Regulator framework

fc89f86e06c11b8828ce1d6c669f724877546c03
ARM: OMAP3: Fix 3430SDP defconfig

 Tomi
