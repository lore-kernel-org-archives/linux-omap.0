From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: RE: [pacth] I2C bug fixes for L-O and L-Z
Date: Mon, 23 Feb 2009 15:37:53 +0200
Message-ID: <1235396273.12653.8.camel@eenurkka-desktop>
References: <1234767724.16827.7.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE896716203771DC940@dlee02.ent.ti.com>
	 <1234850560.13109.9.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE896716203771DD194@dlee02.ent.ti.com>
	 <13B9B4C6EF24D648824FF11BE896716203772C3CAF@dlee02.ent.ti.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37882 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254AbZBWNkK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 08:40:10 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203772C3CAF@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2009-02-20 at 21:59 +0100, ext Woodruff, Richard wrote:
> 
> I received the following comment from a HW Apps person whom has dealt with this at the board level.
> 
> <comment start>
> Attached is the I2C spec that I have.  As I understand it, the I2C only specify the minimum tLow and tHigh (which is not "balanced").  However what is more important is that the appropriate setup and hold time are followed.
> 
> If the equal time still meets the setup/hold time then there should not be any issue from a compliance standpoint.
> <comment end>
> 
> Regards,
> Richard W.

Hi,

With out board, the tLow and tHigh values are in line with I2C standard
with the patch:
http://marc.info/?l=linux-omap&m=122770723311340&w=2

Would that risk the setup and hold times? (If I remember correctly, the
values (setup, hold) were within the I2C standard even with the patch.)

I think it's a risk not to meet tLow and tHigh. I'm saying, with open
source values with our board, the tLow was not in standard. If using
TRM minimum values, things get even worse. Why? because it states, for
example, Fast Mode SCLL = 5 and SCLH = 7. This means that the low
period is smaller than the high! Shouldn't it be vice versa? (scope
verified).

- Eero

