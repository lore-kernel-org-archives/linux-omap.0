From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: Re: Problems with 2430 NAND prefetch engine
Date: Sun, 13 Apr 2008 12:18:23 -0700
Message-ID: <a46a26fd0804131218g51573af0o24d2118c957b631a@mail.gmail.com>
References: <a46a26fd0804081733i469936d4m3315f3bb3270ff5@mail.gmail.com>
	 <20080411192227.GH7717@atomide.com>
	 <a46a26fd0804111410x2b2e580cw833480139ec2e666@mail.gmail.com>
	 <AC2D475575504148943F5EB0938951C40236341E@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:49750 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbYDMTSZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Apr 2008 15:18:25 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1252504wff.4
        for <linux-omap@vger.kernel.org>; Sun, 13 Apr 2008 12:18:23 -0700 (PDT)
In-Reply-To: <AC2D475575504148943F5EB0938951C40236341E@dbde01.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Choraria, Rohit" <rohitkc@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Sun, Apr 13, 2008 at 5:22 AM, Choraria, Rohit <rohitkc@ti.com> wrote:
> > Yes, GPMC access without prefetch engine works fine so clocks are on.
>  >
>  > I was able to solve this problem though. U-boot configured CS0 mapping
>  > to be 128MB. If I change this to 64MB it works.
>  > Very strange indeed.
>  >
>
>  Normally this sort of problem would happen if the start address for the NAND map is not aligned to 128MB boundary.

Of course. I seem to have missed that completely. Thanks for the pointer.

 - Juha


-- 
Madness takes it's toll. Please have exact change.
