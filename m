From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 10/11] Revert "serial: omap: unlock the port lock"
Date: Wed, 26 Mar 2014 20:39:11 -0400
Message-ID: <5333732F.6040803@hurleysoftware.com>
References: <1395343807-21618-1-git-send-email-balbi@ti.com> <1395343807-21618-10-git-send-email-balbi@ti.com> <20140325182856.GA31906@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140325182856.GA31906@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-bluetooth@vger.kernel.org, m-karicheri2@ti.com, b32955@freescale.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 03/25/2014 02:28 PM, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140320 12:39]:
>> This reverts commit 0324a821029e1f54e7a7f8fed48693cfce42dc0e.
>>
>> That commit tried to fix a deadlock problem when using
>> hci_ldisc, but it turns out the bug was in hci_ldsic
>> all along where it was calling ->write() from within
>> ->write_wakeup() callback.
>>
>> The problem is that ->write_wakeup() was called with
>> port lock held and ->write() tried to grab the same
>> port lock.
>
> Should this and the next patch be earlier in the series
> as a fix for the v3.15-rc cycle? Should they be cc: stable
> as well?

Well, right now the other fix has had _zero_ testing
so not really a -stable candidate just yet.
