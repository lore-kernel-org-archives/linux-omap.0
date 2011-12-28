From: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Subject: Re: Problem booting Overo Tide at 720MHz
Date: Wed, 28 Dec 2011 18:19:15 +0100
Message-ID: <4EFB4F93.8010604@tu-ilmenau.de>
References: <jdfcf8$7ii$1@dough.gmane.org> <CAGDS+nn7QUpcbbAxXdph_fr_k8Qir_eES811j3_UfX5AaN0=6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wp197.webpack.hosteurope.de ([80.237.132.204]:35971 "EHLO
	wp197.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752332Ab1L1Rmb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Dec 2011 12:42:31 -0500
In-Reply-To: <CAGDS+nn7QUpcbbAxXdph_fr_k8Qir_eES811j3_UfX5AaN0=6Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org

On 12/28/2011 06:09 PM, Steve Sakoman wrote:
> On Wed, Dec 28, 2011 at 7:26 AM, Andre Puschmann
> <andre.puschmann@tu-ilmenau.de> wrote:
>> Hi list,
>>
>> a couple of days ago I was posting a similar issue where Linux wouldn't
>> start after u-boot. I am trying to boot a recent kernel using Steve's
>> omap-3.2 branch on an Overo Tide based board.
>>
>> A recent checkout doesn't boot and hangs after u-boot hands over to the
>> kernel. After some digging I figured out that this has something to do
>> with the OPP settings for running at 720MHz.
>>
>> After commenting out omap3_opp_enable_720Mhz() in opp3xxx_data.c the
>> kernel boots fine.
>>
>> Does this work for all others?
> 
> Seems to work fine for me.
> 
> Give the binary here a try and let me know if it works for you:
> 
> http://feeds.sakoman.com/feeds/yocto/images/omap3-multi/current/
> 
> If it does then perhaps it is a defconfig issue. If not, then I need
> to dig up a Tide to try to reproduce.
> 
> Steve

Nope, doesn't work either. The funny thing is that it works for the
omap3-pm branch which has the 720MHz thing included, too. So maybe the
workaround is just hiding something else?

Andre
