From: Russ Dill <russ.dill@gmail.com>
Subject: Re: Benchmarking: POP flash vs. MMC?
Date: Fri, 3 Apr 2009 17:57:17 -0700
Message-ID: <f9d2a5e10904031757m5f4fe968mb50b9d58e17501dc@mail.gmail.com>
References: <6541c55b1b4ad133498add734c9eecc8.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:11624 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756495AbZDDA5T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 20:57:19 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1409419rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2009 17:57:17 -0700 (PDT)
In-Reply-To: <6541c55b1b4ad133498add734c9eecc8.squirrel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: david.hagood@gmail.com
Cc: linux-omap@vger.kernel.org

On Fri, Apr 3, 2009 at 2:24 PM,  <david.hagood@gmail.com> wrote:
> Has anybody done any benchmarking on POP flash read/write speeds (using
> JFFS2) vs. MMC/SDHC card access (using ext[234])? Or for that matter, has
> anybody done any playing around with using the execute in place function
> of JFFS2 to see if there is any over-all speed advantage (due to reduced
> pressure on the RAM) vs. loading into RAM?
>

UBIFS on POP NAND
Version 1.03c       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
beagleboard    300M  2333  86 19899  45 10420  59  2289  95 17719  93  2060  93
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  5310  94  7931  96  4439  87  4734  85 +++++ +++  3082  95
beagleboard,300M,2333,86,19899,45,10420,59,2289,95,17719,93,2060.1,93,16,5310,94,7931,96,4439,87,4734,85,+++++,+++,3082,95

ext3 (noatime,async,data=ordered) on MMC (4GB class 6)
Version 1.03c       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
beagleboard    300M  2026  81  4553  11  4281   6  2502  92 16079  14  1672  23
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  7135  95 +++++ +++ 12173  95  5040  67 +++++ +++ 11766  96
beagleboard,300M,2026,81,4553,11,4281,6,2502,92,16079,14,1672.3,23,16,7135,95,+++++,+++,12173,95,5040,67,+++++,+++,11766,96

ext3 (noatime,async,data=writeback) on MMC (4GB class 6)
Version 1.03c       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
beagleboard    300M  2343  85 19370  40 10937  61  2312  95 19176  94  3122  93
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  5194  93  7863  95  4511  87  4970  89 +++++ +++  3076  95
beagleboard,300M,2343,85,19370,40,10937,61,2312,95,19176,94,3122.3,93,16,5194,93,7863,95,4511,87,4970,89,+++++,+++,3076,95
