From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/4] cbus: add of_match_table
Date: Fri, 4 Nov 2011 13:42:40 +0100
Message-ID: <4EB3DDC0.3000407@ti.com>
References: <1318884643-4137-1-git-send-email-balbi@ti.com> <20111103214559.GB31337@atomide.com> <20111104091305.GA691@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39705 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038Ab1KDMmn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Nov 2011 08:42:43 -0400
In-Reply-To: <20111104091305.GA691@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi Felipe,

On 11/4/2011 10:13 AM, Balbi, Felipe wrote:
> Hi,
>
> On Thu, Nov 03, 2011 at 02:45:59PM -0700, Tony Lindgren wrote:
>> * Felipe Balbi<balbi@ti.com>  [111017 13:16]:
>>> then we can make DeviceTree conversion happen.
>>
>> Cool. Looks like n800 keeps running after these, pushing
>> to cbus branch.
>
> need to find out a way to create all devices via devicetree. Do you have
> a branch which I could patch on top of ?

The latest mainline master branch does contain the first DT patches for 
basic OMAP3 & 4 support. You can probably start from here for OMAP2 DT 
support as well.

Regards,
Benoit
