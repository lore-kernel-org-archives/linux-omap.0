From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 7/8] perf timechart: Map power:cpu_idle events to the corresponding cpuidle state
Date: Thu, 2 Dec 2010 17:51:39 +0100
Message-ID: <201012021751.39865.trenn@suse.de>
References: <1291308148-28628-1-git-send-email-trenn@suse.de> <1291308148-28628-7-git-send-email-trenn@suse.de> <1291308148-28628-8-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291308148-28628-8-git-send-email-trenn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 02 December 2010 17:42:27 Thomas Renninger wrote:
> Before, power:cpu_idle events were very specific X86 Intel mwait events.
> This got fixed with previous patches and cpu_idle events are now thrown by
> all cpuidle drivers and can be mapped to the corresponding cpuidle state
> in /sys.
> 
> This patch reads out the corresponding cpuidle name of a cpu_idle event
> and uses it in the title line of the chart (c-states Cx in x86, omap2
> - DDR self refresh states for various arm archs).
> 
> It also reads out the corresponding abbr(eviation) and uses the string
> to draw the cpu idle occurences. This needs a short (3 letter) string
> to keep the overview in the chart.

I forgot two other changes:
  - Fixes black c-state drawings in eog and firefox:
    class="rect.cX" is wrong and must be class="cX"
  - Use green color instead of red for idle drawings. This does not clash
    with the Block IO drawings (also red) and better fits the "green IT"
    background the C-states are about :) (that was not really the reason,
    green was one of the last not used colors)...

 Thomas
