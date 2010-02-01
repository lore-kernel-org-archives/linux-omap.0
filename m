From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Bug: access to already released memory
Date: Mon, 1 Feb 2010 14:27:02 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002011426400.20004@utopia.booyaka.com>
References: <a328840c1001301356r14505614pbb4563754c6890ac@mail.gmail.com>  <20100131035540.GA13428@linux-sh.org> <a328840c1001310200n6314cf2emf69656b807fcb191@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42313 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031Ab0BAV1F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 16:27:05 -0500
In-Reply-To: <a328840c1001310200n6314cf2emf69656b807fcb191@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marek Skuczynski <mareksk7@gmail.com>
Cc: linux-omap@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

On Sun, 31 Jan 2010, Marek Skuczynski wrote:

> Hello,
>    I have found an access to already released memory in
> clk_debugfs_register_one() function,
>    attaching a patch. The included patch was prepared for Linux 2.6 repository.
> 

Acked-by: Paul Walmsley <paul@pwsan.com>

Thanks Marek and Paul.


- Paul
