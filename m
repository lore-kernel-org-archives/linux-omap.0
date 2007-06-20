From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: Help in regard of MMC slot with SDP2430
Date: Wed, 20 Jun 2007 10:23:22 +0530
Message-ID: <001301c7b2f6$ee1549e0$128918ac@ent.ti.com>
References: <80f873930706191656o4f12d175of42d4b6f0825dd6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <80f873930706191656o4f12d175of42d4b6f0825dd6f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'sree' <sreesamb@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

To enable power to MMC slot, you need to configure the VMMC LDO's. The
voltage can be configured through the TWL registers VMMC1_DEDICATED and
VMMC2_DEDICATED for slot1 and slot2 respectively.

Also take a look at the VMMC1_DEV_GRP and VMMC2_DEV_GRP registers.

Regards,
Madhu



-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of sree
Sent: Wednesday, June 20, 2007 5:26 AM
To: linux-omap-open-source@linux.omap.com
Subject: Fwd: Help in regard of MMC slot with SDP2430

Hi
I am working on MMC drivers for SDP2430 with 2.6.20 kernel and with
reference to the 2.6.14. The LED related to the MMC slot is not
on.whichmeans the power for MMC slot is not
enabled.Is it related to the TWL4030 board drivers or they related to the
Host MMC controllers.I am little confused on this, need the correct way to
solve this. Any help please
thanks
sree



--
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
