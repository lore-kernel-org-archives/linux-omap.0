From: Francisco Alecrim <francisco.alecrim@indt.org.br>
Subject: Re: [RFC/PATH] OMAP: HSMMC: Fixes for 1.8V MMC2 interface
Date: Wed, 02 Apr 2008 03:46:44 +0300
Message-ID: <47F2D774.2060308@indt.org.br>
References: <20080331014640.GA14188@ubuntu-workstation> <47F14D61.5030109@indt.org.br> <20080401005137.GA22520@ubuntu-workstation> <004901c8940b$20f1fca0$438918ac@ent.ti.com> <20080401161617.GA28624@ubuntu-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54756 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbYDBAqz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Apr 2008 20:46:55 -0400
In-Reply-To: <20080401161617.GA28624@ubuntu-workstation>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, linux-omap@vger.kernel.org

ext Seth Forshee wrote:
> On Tue, Apr 01, 2008 at 08:44:47PM +0530, Madhusudhan Chikkature Rajashekar wrote:
>   
>> Hi,
>>
>> I did not see any board level code to power up the second slot along with this patch.
>> Where is the code that enables 1.8V to the second slot?
>>     
>
> I am working with a custom board that isn't supported in the git repo, and I
> don't have access to any other board that I could test such changes with.
> These are just the chages I found were necessary to support the 1.8V-only
> host, regardless of whatever board support is needed.

That's the same problem here!! I have a custom board too!! However, 
pushing patches [1] and [2] we will be able to enable the second 
controller with some modifications in board-sdp-mmc.c.

[1] - OMAP: HSMMC: Fixes for 1.8V MMC2 interface
[2] - [PATCH 1/1] PLAT: OMAP: Add device configuration to support second 
HSMMC slot on OMAP 2430 and 3430 boards.

-- 
Francisco Keppler Silva Alecrim - INdT
Phone: +55 92 2126-1017
Mobile: +55 92 9152-7000

