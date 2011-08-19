From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 1/3] trace points: power: remove 'cpu_id' from trace_clock_*
Date: Fri, 19 Aug 2011 23:39:55 +0800
Message-ID: <CACVXFVNKe+gt2VmrHcJ2Pd1ZvqfOPn+211vR-PcM-WDTYDN4cQ@mail.gmail.com>
References: <1313766244-22313-1-git-send-email-tom.leiming@gmail.com>
	<1313766840.15704.104.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1313766840.15704.104.camel@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: fweisbec@gmail.com, jean.pihet@newoldbits.com, mingo@redhat.com, trenn@suse.de, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Aug 19, 2011 at 11:14 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> Do you know if these changes wont break powertop?

I have run powertop 1.13 on these changes, and found it works well
just like before,
no breaks found.

thanks,
-- 
Ming Lei
