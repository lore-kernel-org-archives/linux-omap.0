From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: Linux kernel for OMAP5432 uEVM
Date: Wed, 31 Jul 2013 14:01:54 +0530
Message-ID: <51F8CB7A.9070108@ti.com>
References: <20130730033808.GA23486@cbz-workstation> <51F7387B.9060304@ti.com> <D890FDE7-B6AD-48E9-BE9C-3835F95E4457@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40949 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab3GaIb6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Jul 2013 04:31:58 -0400
In-Reply-To: <D890FDE7-B6AD-48E9-BE9C-3835F95E4457@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Baozi <baozich@gmail.com>
Cc: linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Hi Chen,

On Wednesday 31 July 2013 01:19 PM, Chen Baozi wrote:
> 
> On Jul 30, 2013, at 11:52 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
> 
>> You can also use Linus's kernel with the above clk data branch.( OMAP5 uEVM boots)
>> Please let me know if you need more info.
> 
> And the ethernet driver is not available by default?
You need the following patch series recently posted by Roger:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92694.html

Thanks and regards,
Lokesh
> 
> Cheers,
> 
> Baozi
> 

