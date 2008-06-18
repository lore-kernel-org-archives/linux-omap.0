From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH/RFC 1/2] Add Dspbridge driver to OMAP GIT kernel
Date: Wed, 18 Jun 2008 18:34:45 +0530
Message-ID: <5d5443650806180604r26d1a8e1r51d0aeecc4a55d69@mail.gmail.com>
References: <A8E8DDC23969AE4CB38FFF51016C778202D975BA@dlee10.ent.ti.com>
	 <ECC99C9B-90E9-4D91-9E74-7999D3868D20@student.utwente.nl>
	 <5d5443650806140650w22463060v3a3ad260ef144c97@mail.gmail.com>
	 <A8E8DDC23969AE4CB38FFF51016C778202D97C4B@dlee10.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:36404 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993AbYFRNEs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jun 2008 09:04:48 -0400
Received: by fk-out-0910.google.com with SMTP id 18so284312fkq.5
        for <linux-omap@vger.kernel.org>; Wed, 18 Jun 2008 06:04:47 -0700 (PDT)
In-Reply-To: <A8E8DDC23969AE4CB38FFF51016C778202D97C4B@dlee10.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "Gupta, Ramesh" <grgupta@ti.com>, linux-omap@vger.kernel.org

Hi Hari,

On 6/17/08, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Hi Trilok,
>
> > This code is sitting on pile of un-necessary wrappers, doesn't use
> > common frameworks which were already written once for nokia
> > dspgateway,
>
> --- This is addressed in the email sent to the mailing list.
>
> > I am sure it will not pass checkpatch and sparse screening
> > tests even.
>
> --- The checkpatch (version 18) is ran on the patch file that is sent to
> the mailing list, and we observed only 65 errors (most of them are false
> errors reported by checkpatch), and there are around 365 warnings
> (mostly complaints on typedefs)
>
>
> >, doesn't use
> > common frameworks which were already written once for nokia
> > dspgateway,
>
> ---- It is agreed with Doyu-san that we will consider this as a long
> term plan.
>

Setting up a GIT tree for dspbridge driver, should not be on long term
plan, as long term plan should be to get dspbridge merged on to OMAP
GIT itself. In this case separate GIT tree, should serve as staging
tree and playground for cleanups so that others (specifically outside
TI guys) can watch your commits/comment and help you guys on cleanups.
It is really tough to track and review your changes as you are putting
very big patches and we are unable to keep sync with your changes in
incremental fashion.

For most of the open source guys, setting up GIT tree is sometime
first step in-order to make changes visible to others in better way :)


-- 
---Trilok Soni
http://triloksoni.wordpress.com
