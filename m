From: Paul Walmsley <paul@pwsan.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Tue, 1 May 2012 23:59:15 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205012358230.19695@utopia.booyaka.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com> <877gxobudk.fsf@ti.com> <CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com> <87ehrtn6na.fsf@ti.com> <CANOLnOM_-yhr-j=UO3ynJ6HyJxzd_2FshPMXMLpcBcOB0mL7Qw@mail.gmail.com>
 <87y5puwhus.fsf@ti.com> <CAORVsuWP72dHFSBhX=Kux7GEk33qQgR74a74FFwzA8uniSabAQ@mail.gmail.com> <877gx5dwz2.fsf@ti.com> <CAORVsuXX9c+8-uJ1e1U920_jy0MK53jmCu+hXhHaXapHArMeLg@mail.gmail.com> <87txzzhkvh.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34428 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124Ab2EBF7Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 01:59:16 -0400
In-Reply-To: <87txzzhkvh.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org

On Tue, 1 May 2012, Kevin Hilman wrote:

> PER is the one that seems to be causing the most latency.  
> 
> Can you try do your measurements using hack below which makes sure that
> PER isn't any deeper than CORE?

It might be the relock time for DPLL4, the PER DPLL.  You might also 
try disabling DPLL4 autoidle for the shallow C-states...
 

- Paul
