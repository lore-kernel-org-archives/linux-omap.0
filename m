From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: NAND flash update via serial debug console
Date: Thu, 20 Jan 2011 11:11:41 -0700
Message-ID: <4D387ADD.60104@mlbassoc.com>
References: <63326177-4F9F-4A5C-BCE4-FDFD182791D6@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:50551 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295Ab1ATSUt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 13:20:49 -0500
In-Reply-To: <63326177-4F9F-4A5C-BCE4-FDFD182791D6@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>

On 01/20/2011 10:21 AM, Elvis Dowson wrote:
> Hi,
>         Is it possible to flash NAND via the serial debug console for OMAP35xx devices?

If you have U-Boot running, you can download whatever you
need via Y-Modem (loady command) and then update the NAND
as needed.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
