From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 10/11] Revert "serial: omap: unlock the port lock"
Date: Wed, 26 Mar 2014 22:27:13 -0400
Message-ID: <53338C81.3060600@hurleysoftware.com>
References: <1395343807-21618-1-git-send-email-balbi@ti.com> <1395343807-21618-10-git-send-email-balbi@ti.com> <20140325182856.GA31906@atomide.com> <5333732F.6040803@hurleysoftware.com> <20140327021043.GB11651@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140327021043.GB11651-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m-karicheri2-l0cyMroinI0@public.gmane.org, b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 03/26/2014 10:10 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Mar 26, 2014 at 08:39:11PM -0400, Peter Hurley wrote:
>> On 03/25/2014 02:28 PM, Tony Lindgren wrote:
>>> * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [140320 12:39]:
>>>> This reverts commit 0324a821029e1f54e7a7f8fed48693cfce42dc0e.
>>>>
>>>> That commit tried to fix a deadlock problem when using
>>>> hci_ldisc, but it turns out the bug was in hci_ldsic
>>>> all along where it was calling ->write() from within
>>>> ->write_wakeup() callback.
>>>>
>>>> The problem is that ->write_wakeup() was called with
>>>> port lock held and ->write() tried to grab the same
>>>> port lock.
>>>
>>> Should this and the next patch be earlier in the series
>>> as a fix for the v3.15-rc cycle? Should they be cc: stable
>>> as well?
>>
>> Well, right now the other fix has had _zero_ testing
>> so not really a -stable candidate just yet.
>
> how can you even say that ?

I misunderstood when you wrote:

On 03/20/2014 02:11 PM, Felipe Balbi wrote:
 > here's a build-tested only patch which is waiting for testing from other
 > colleagues who've got a platform to reproduce the problem:

and then the version I reviewed had no Tested-by: tags.

> Unless you work for some 3 letter acronym
> organizations, you have no clue about the fact that this was tested on a
> keystone 2 platform.

Ok.

> How else would we have found the issue to start with ?

Bug report?

Regards,
Peter Hurley
