From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] power: isp1704: fix probe error path
Date: Wed, 14 Mar 2012 03:29:36 +0400
Message-ID: <20120313232936.GB24552@oksana.dev.rtsoft.ru>
References: <1328058229-29014-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49618 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605Ab2CMX3m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Mar 2012 19:29:42 -0400
Received: by bkcik5 with SMTP id ik5so842307bkc.19
        for <linux-omap@vger.kernel.org>; Tue, 13 Mar 2012 16:29:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1328058229-29014-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, Clifton Barnes <cabarnes@indesign-llc.com>, Axel Lin <axel.lin@gmail.com>

On Wed, Feb 01, 2012 at 03:03:47AM +0200, Felipe Contreras wrote:
> We enable power, but don't disable it in case of an error.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Applied, thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
