From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 00/28] OMAP: DSS related board file changes
Date: Sun, 31 Mar 2013 11:41:46 +0300
Message-ID: <5157F6CA.2020901@compulab.co.il>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com> <51546259.3000704@compulab.co.il> <51547462.3070803@ti.com> <20130328165752.GX10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:52651 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755160Ab3CaIlw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Mar 2013 04:41:52 -0400
In-Reply-To: <20130328165752.GX10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>



On 03/28/13 18:57, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130328 09:53]:
>> On 2013-03-28 17:31, Igor Grinberg wrote:
>>> On 03/28/13 14:48, Tomi Valkeinen wrote:
>>>
>>> I've missed this discussion, can you please point to it?
>>
>> Well, not so much discussion, but a few mails under "Display related
>> board specific boot args" subject on l-o. I proposed a board specific
>> kernel argument to select the displays present, Tony was less than
>> enthusiastic about that.
> 
> If we can come up with a Linux generic command line option to select
> the panel that can be supported also in the long run, I have no
> objections to that naturally. What I'm against is a temporary
> custom cmdline option until the board-*.c files go away as we
> don't want to support it in the long run.

Agreed totally, the panel select option does not have to be
board specific (and it better not be...).


-- 
Regards,
Igor.
