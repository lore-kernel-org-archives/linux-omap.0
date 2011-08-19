From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 1/3] trace points: power: remove 'cpu_id' from trace_clock_*
Date: Fri, 19 Aug 2011 09:16:18 -0700
Message-ID: <4E4E8C52.6070900@linux.intel.com>
References: <1313766244-22313-1-git-send-email-tom.leiming@gmail.com> <1313766840.15704.104.camel@gandalf.stny.rr.com> <CACVXFVNKe+gt2VmrHcJ2Pd1ZvqfOPn+211vR-PcM-WDTYDN4cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACVXFVNKe+gt2VmrHcJ2Pd1ZvqfOPn+211vR-PcM-WDTYDN4cQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, fweisbec@gmail.com, jean.pihet@newoldbits.com, mingo@redhat.com, trenn@suse.de, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 8/19/2011 8:39 AM, Ming Lei wrote:
> Hi,
>
> On Fri, Aug 19, 2011 at 11:14 PM, Steven Rostedt<rostedt@goodmis.org>  wrote:
>> Do you know if these changes wont break powertop?
> I have run powertop 1.13 on these changes, and found it works well
> just like before,
> no breaks found.
please use powertop 1.98 instead
1.13 does not use trace events while 1.98 does

>
> thanks,
