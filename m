From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: mysterious crashes on OMAP5 uevm
Date: Mon, 14 Sep 2015 21:35:10 +0200
Message-ID: <4A24D632-D980-4C37-B2C9-88D3E9D429D7@goldelico.com>
References: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
 <20150908143810.GD4215@atomide.com>
 <CANOLnOODjTaBcL1QzAm7o4YOB=_P-s7JYovu6fhNSqJSV2Bq+Q@mail.gmail.com>
 <20150908210708.GH4215@atomide.com>
 <E0068B56-0DEE-4E2F-94CF-DB104AE16D63@goldelico.com>
 <20150910083026.GA21098@n2100.arm.linux.org.uk>
 <CANOLnOM-PYcAL=f4rgucfdWZ1+U3HkP34bfwrKP4Rob+J6iTfw@mail.gmail.com>
 <20150911140306.GB21098@n2100.arm.linux.org.uk>
 <20150914121248.GD21098@n2100.arm.linux.org.uk>
 <20150914190236.GV4215@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150914190236.GV4215@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Grazvydas Ignotas <notasas@gmail.com>, Marek Belisko <marek@goldelico.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


Am 14.09.2015 um 21:02 schrieb Tony Lindgren <tony@atomide.com>:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150914 05:16]:
>> On Fri, Sep 11, 2015 at 03:03:07PM +0100, Russell King - ARM Linux wrote:
>>> 
>>> Merely changing __LINUX_ARM_ARCH__ >= 7 to >= 6 should fix the problem,
>>> and I doubt there's any ARMv6 non-T2 systems out there that would be
>>> affected by clearing the IT state bits.
>> 
>> Please test the following patch:
> 
> While we're waiting for Grazvydas to test.. Looks good to me:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

I have tested on:
* GTA04 with DM3730 (OMAP3)
* Pyra prototype with OMAP5432
No X server crashes seen any more.

Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
