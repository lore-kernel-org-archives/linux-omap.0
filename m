From: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] omap: i2c: Add calls for pinctrl state select
Date: Wed, 22 Apr 2015 10:50:28 +0200
Message-ID: <553760D4.4020506@gmail.com>
References: <1429283277-28161-1-git-send-email-pascal.huerst@gmail.com> <20150422081240.GH1511@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150422081240.GH1511@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hey Wolfram,

On 22.04.2015 10:12, Wolfram Sang wrote:
> On Fri, Apr 17, 2015 at 05:07:57PM +0200, pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> From: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> This adds calls to pinctrl subsystem in order to switch pin states
>> on suspend/resume if you provide a "sleep" state in DT.
>>
>> Signed-off-by: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> ? Don't you get a build error? I do. Rightfully, I'd think, there is no
> pinctrl-include.

You are right, the include is missing. I just reapplied the patch,
compiled and interestingly enough, I don't get any compile errors. (?)
Some further checks revealed, that the include is also missing in
drivers/i2c/busses/i2c-st.c - which I used to get the idea on how to use
these calls.

I'm using a buildroot toolchain:
gcc version 4.9.2 (Buildroot 2014.11-00023-g60d7a19-dirty)

Do you have any idea on where these differences are coming from?

In any case, the include belongs there, so I will resend that patch.

regards
pascal
