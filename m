From: Roger Quadros <rogerq@ti.com>
Subject: Re: Linux kernel for OMAP5432 uEVM
Date: Wed, 31 Jul 2013 14:31:53 +0300
Message-ID: <51F8F5A9.5080308@ti.com>
References: <20130730033808.GA23486@cbz-workstation> <51F7387B.9060304@ti.com> <D890FDE7-B6AD-48E9-BE9C-3835F95E4457@gmail.com> <51F8CB7A.9070108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41449 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754155Ab3GaLbz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Jul 2013 07:31:55 -0400
In-Reply-To: <51F8CB7A.9070108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Chen Baozi <baozich@gmail.com>, linux-omap@vger.kernel.org

On 07/31/2013 11:31 AM, Lokesh Vutla wrote:
> Hi Chen,
> 
> On Wednesday 31 July 2013 01:19 PM, Chen Baozi wrote:
>>
>> On Jul 30, 2013, at 11:52 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
>>
>>> You can also use Linus's kernel with the above clk data branch.( OMAP5 uEVM boots)
>>> Please let me know if you need more info.
>>
>> And the ethernet driver is not available by default?
> You need the following patch series recently posted by Roger:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92694.html
> 

Those will work only if you proceed with Tero's clock data in DT approach.

cheers,
-roger

