From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: mmc errors (was Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3)
Date: Wed, 24 Mar 2010 10:35:12 -0500
Message-ID: <000201cacb67$9849e4d0$544ff780@am.dhcp.ti.com>
References: <20100322212025.GW11448@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026F127117@dbde02.ent.ti.com>
	<20100323152709.GD11448@atomide.com> <4BA94564.8030803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4BA94564.8030803@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Nishanth Menon' <nm@ti.com>, 'Tony Lindgren' <tony@atomide.com>
Cc: "'Pandita, Vikram'" <vikram.pandita@ti.com>, linux-omap@vger.kernel.org, "'Pais, Allen'" <allen.pais@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Nishanth Menon [mailto:nm@ti.com]
> Sent: Tuesday, March 23, 2010 5:49 PM
> To: Tony Lindgren
> Cc: Pais, Allen; linux-arm-kernel@lists.infradead.org; linux-
> omap@vger.kernel.org; Pandita, Vikram; Madhusudhan Chikkature Rajashekar
> Subject: mmc errors (was Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3)
> 
> Tony Lindgren had written, on 03/23/2010 10:27 AM, the following:
> [...]
> > Then at least one issue remains for zoom3 to be usable..
> > I'm getting tons of MMC errors trying to mount root on it:
> >
> > mmcblk1: error -110 transferring data, sector 2097024, nr 8, card status
> 0x900
> > end_request: I/O error, dev mmcblk1, sector 2097024
> > ...
> >
> I have seen this on few platforms and seem to be related to eMMC usage.
> 
> > Any ideas if that's fixed somewhere also?
> Madhu, any comments?
> 
Sorry about multiple replies to this mail. Just wanted to avoid top posting.

The eMMC on Zoom2 has an issue with respect to detection as a high
capacity card. This was discussed on the list with Pierre sometime back. I
don't have an acceptable solution to make this device work. Rather I
prefer to submit a patch which disables MMC2 on these boards.
 
You can still use MMC1 to mount your file system. This is the card you can
plug in to the cage.
 
Regards,
Madhu

> --
> Regards,
> Nishanth Menon
