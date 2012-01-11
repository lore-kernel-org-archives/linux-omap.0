From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH V2 1/2] mcx: very basic support for HTKW mcx board
Date: Thu, 12 Jan 2012 02:03:39 +0400
Message-ID: <4F0E073B.1000008@emcraft.com>
References: <1323910383-1184-1-git-send-email-yanok@emcraft.com> <1323910383-1184-2-git-send-email-yanok@emcraft.com> <20111217013740.GF6464@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:44460 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933984Ab2AKWDi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jan 2012 17:03:38 -0500
In-Reply-To: <20111217013740.GF6464@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, sasha_d@emcraft.com

Hi Tony,

as you probably seen we've got an ACK from Grant Likely for the
mt_ventoux DT-only support patch (which is really the same as this one,
only board name/vendor changed). Probably you can now merge support for
both boards?

Regards, Ilya.

On 17.12.2011 05:37, Tony Lindgren wrote:
> * Ilya Yanok <yanok@emcraft.com> [111214 16:21]:
>> Very basic support for HTKW mcx board. Able to boot via board-generic
>> and ramdisk/initramfs, however most of peripherals is unsupported.
>> Produces tons of twl4030 related errors as this board doesn't have
>> twl4030 installed.
> 
> Please resend with linux-arm-kernel and devicetree-discuss
> lists in Cc. We need an ack from the devicetree people for this.
> 
> Tony

