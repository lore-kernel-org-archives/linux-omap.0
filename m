From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: disable_irq is broken in linux-omap-git
Date: Mon, 13 Oct 2008 11:01:37 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620365C43BF4@dlee02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301B020CBE5@dbde02.ent.ti.com>
 <5e088bd90810130851o1e3f7860tb0ff50fcbd83587a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38571 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999AbYJMQBq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2008 12:01:46 -0400
In-Reply-To: <5e088bd90810130851o1e3f7860tb0ff50fcbd83587a@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> On Mon, Oct 13, 2008 at 2:51 AM, TK, Pratheesh Gangadhar
> <pratheesh@ti.com> wrote:
> > FYI, this seems to be currently broken as default_disable in
> kernel/irq/chip.c is defined to be an EMPTY function. It will affect
> drivers using disable_irq and following patch fixes it.
>
> It has been an empty function for more than a year and a half -- see
> the following patch for the reason it was removed:
>
> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-
> 2.6.git;a=commit;h=76d2160147f43f982dfe881404cfde9fd0a9da21

That comment seems fairly x86 specific.  Instead imposing on everyone else it would have been nice for them to install a dummy handler in the irq-chip setup.

Regards,
Richard W.

