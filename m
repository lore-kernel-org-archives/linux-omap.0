From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: mysterious crashes on OMAP5 uevm
Date: Fri, 11 Sep 2015 16:12:21 +0000
Message-ID: <EF62F09C0797D947AD4180A1043C0DF740C23E8D@DLEE11.ent.ti.com>
References: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
 <20150908143810.GD4215@atomide.com>
 <CANOLnOODjTaBcL1QzAm7o4YOB=_P-s7JYovu6fhNSqJSV2Bq+Q@mail.gmail.com>
 <20150908210708.GH4215@atomide.com>
 <E0068B56-0DEE-4E2F-94CF-DB104AE16D63@goldelico.com>
 <20150910083026.GA21098@n2100.arm.linux.org.uk>
 <CANOLnOM-PYcAL=f4rgucfdWZ1+U3HkP34bfwrKP4Rob+J6iTfw@mail.gmail.com>
 <20150911140306.GB21098@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150911140306.GB21098@n2100.arm.linux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Grazvydas Ignotas <notasas@gmail.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Friday, September 11, 2015 9:03 AM
> To: Grazvydas Ignotas

> However, even the idea that it's ARMv7 or later is wrong.  According to
> the ARM ARM, the IT instruction is present in ARMv6T2 as well, which
> means it's ARMv6 too (which would have __LINUX_ARM_ARCH__ = 6).

I recall seeing ARMv6T2 first implemented in the ARM1156 which is a v6 CPU with T2 option added.

Cortex-R class was the ARMv7 successor to the 1156 CPU which also use T2.

> Looking at the ARM ARM, these bits are "reserved" in previous non-T2
> architectures, have an undefined value at reset, and are probably zero
> anyway.
> 
> Merely changing __LINUX_ARM_ARCH__ >= 7 to >= 6 should fix the
> problem,
> and I doubt there's any ARMv6 non-T2 systems out there that would be
> affected by clearing the IT state bits.

Probably you already looked, but cpsr.it usage is not restricted to this one spot.

Looking back at old notes I think both debug and signal handler code keyed on bit usage.  I see from LXR kernel KVM code also uses in some capacity.

The 1156/Cortex-R are typically MMU-less.   They may (or not) have something else to consider when fixing.

Regards,
Richard W.
