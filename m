From: Tero Kristo <t-kristo@ti.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Tue, 24 Apr 2012 16:04:10 +0300
Message-ID: <1335272650.2149.91.camel@sokoban>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	 <877gxobudk.fsf@ti.com>
	 <CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
	 <87ehrtn6na.fsf@ti.com>
	 <CANOLnOM_-yhr-j=UO3ynJ6HyJxzd_2FshPMXMLpcBcOB0mL7Qw@mail.gmail.com>
	 <87y5puwhus.fsf@ti.com>
	 <CAORVsuWP72dHFSBhX=Kux7GEk33qQgR74a74FFwzA8uniSabAQ@mail.gmail.com>
	 <4F96828B.1090902@ti.com> <1335270113.2149.87.camel@sokoban>
	 <CAORVsuU2aBMOk5-Vbi17zpM82U7q+kX5NE0eV0Y-9S82=-uWAA@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42586 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754012Ab2DXNEP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 09:04:15 -0400
In-Reply-To: <CAORVsuU2aBMOk5-Vbi17zpM82U7q+kX5NE0eV0Y-9S82=-uWAA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Tue, 2012-04-24 at 14:50 +0200, Jean Pihet wrote:
> Hi Tero,
> 
> On Tue, Apr 24, 2012 at 2:21 PM, Tero Kristo <t-kristo@ti.com> wrote:
> > On Tue, 2012-04-24 at 16:08 +0530, Santosh Shilimkar wrote:
> >> + Tero
> >>
> >> On Tuesday 24 April 2012 03:20 PM, Jean Pihet wrote:
> >> > Hi Grazvydas, Kevin,
> >> >
> >> > I did some gather some performance measurements and statistics using
> >> > custom tracepoints in __omap3_enter_idle.
> >> > All the details are at
> >> > http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement#C1_performance_problem:_analysis
> >> > .
> >> >
> >> Nice data.
> >>
> >> > The setup is:
> >> > - Beagleboard (OMAP3530) at 500MHz,
> >> > - l-o master kernel + functional power states + per-device PM QoS. It
> >> > has been checked that the changes from l-o master do not have an
> >> > impact on the performance.
> >> > - The data transfer is performed using dd from a file in JFFS2 to
> >> > /dev/null: 'dd if=/tmp/mnt/a of=/dev/null bs=1M count=32'.
> >
> > Question: what is used for gathering the latency values?
> I used ftrace tracepoints which are supposed to be low overhead. I
> checked that the overhead cannot be measured on the measurement
> interval (>400us), given the fact that the time base is 31us (32 KHz
> clock).

If you want to get accurate measurements, you could use ARM performance
counters, namely the cycle counter. I have a couple of patches for that
purpose I've used if you are interested.

-Tero

