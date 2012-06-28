From: =?UTF-8?B?IkFuZHkgR3JlZW4gKOael+WuieW7uCki?= <andy@warmcat.com>
Subject: Re: [RFC PATCH 0/2] OMAP2+: PANDA: Provide unique-ish MAC addresses
 for Ethernet and WLAN interfaces
Date: Thu, 28 Jun 2012 22:49:46 +0800
Message-ID: <4FEC6F0A.5060600@warmcat.com>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com>
 <201206281418.16854.arnd@arndb.de>
 <1340894707.16702.76.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1340894707.16702.76.camel@gandalf.stny.rr.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: nicolas.pitre@linaro.org, s-jan@ti.com, Arnd Bergmann <arnd@arndb.de>, patches@linaro.org, tony@atomide.com, x0132446@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 06/28/12 22:45, the mail apparently from Steven Rostedt included:
> On Thu, 2012-06-28 at 14:18 +0000, Arnd Bergmann wrote:
>
>> It's been a while since we discussed these patches, but Steven Rostedt
>> just tripped over the same problem and the patches work for
>> him, so he says "Tested-by: Steven Rostedt <rostedt@goodmis.org>".
>>
>> Can we get the patches into linux-3.6 please?
>
> Yes please.
>
> Right now I have my ktest.pl setup adding these patches before running
> tests. I really dislike having to modify a kernel that I'm testing,
> because I'm not really testing that said kernel, but a modified version
> of it.

Guys I am glad you're finding the patches useful; I've been using them 
in the Linaro TI Lnding Team trees ever since.

I adapted them a bit to live mainly in devices.c, tomorrow I'll send 
this version cleaned up and we can deal with any further changes needed 
hopefully quickly.

-Andy
