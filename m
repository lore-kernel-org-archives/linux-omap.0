From: Behan Webster <behanw@converseincode.com>
Subject: Re: [PATCH 1/2] arm, fbdev, omap2, LLVMLinux: Remove nested function
 from omap2 dss
Date: Sat, 27 Sep 2014 15:53:56 -0700
Message-ID: <54274004.6010902@converseincode.com>
References: <1411780253-4492-1-git-send-email-behanw@converseincode.com> <1411780253-4492-2-git-send-email-behanw@converseincode.com> <20140927164554.GA7076@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50949 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbaI0WyA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Sep 2014 18:54:00 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so2175770pab.33
        for <linux-omap@vger.kernel.org>; Sat, 27 Sep 2014 15:53:59 -0700 (PDT)
In-Reply-To: <20140927164554.GA7076@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, daniel.vetter@ffwll.ch, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, robdclark@gmail.com, Arnd Bergmann <arnd@arndb.de>

On 09/27/14 09:46, Felipe Balbi wrote:
> On Fri, Sep 26, 2014 at 06:10:52PM -0700, Behan Webster wrote:
>> Replace the use of nested functions where a normal function will suffice.
>>
>> Nested functions are not liked by upstream kernel developers in general. Their
>> use breaks the use of clang as a compiler, and doesn't make the code any
>> better.
>>
>> This code now works for both gcc and clang.
>>
>> Signed-off-by: Behan Webster <behanw@converseincode.com>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Cc: Arnd Bergmann <arnd@arndb.de>
> another one that make sense :-) And probably also deserves
> checkpatch/coccinelle/sparse.
Indeed! That would be very appreciated.

The clang static analyzer already points this one out. :)

Behan

-- 
Behan Webster
behanw@converseincode.com

