From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: disable_irq is broken in linux-omap-git
Date: Mon, 13 Oct 2008 08:51:04 -0700
Message-ID: <5e088bd90810130851o1e3f7860tb0ff50fcbd83587a@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301B020CBE5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:32702 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491AbYJMPvG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2008 11:51:06 -0400
Received: by an-out-0708.google.com with SMTP id d40so133774and.103
        for <linux-omap@vger.kernel.org>; Mon, 13 Oct 2008 08:51:05 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301B020CBE5@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Oct 13, 2008 at 2:51 AM, TK, Pratheesh Gangadhar
<pratheesh@ti.com> wrote:
> FYI, this seems to be currently broken as default_disable in kernel/irq/chip.c is defined to be an EMPTY function. It will affect drivers using disable_irq and following patch fixes it.

It has been an empty function for more than a year and a half -- see
the following patch for the reason it was removed:

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=76d2160147f43f982dfe881404cfde9fd0a9da21
