From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: Remove unnecessary memset in dsp task.c
Date: Tue, 05 Dec 2006 09:44:32 +0200 (EET)
Message-ID: <20061205.094432.71469176.Hiroshi.DOYU@nokia.com>
References: <3a5b1be00612041027h2e3cefefwf140897ee1bb4717@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3a5b1be00612041027h2e3cefefwf140897ee1bb4717@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: komal.shah802003@gmail.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: "ext Komal Shah" <komal.shah802003@gmail.com>
Subject: [PATCH] ARM: OMAP: Remove unnecessary memset in dsp task.c
Date: Mon, 4 Dec 2006 23:57:26 +0530

> There is much more duplicated code can be removed in task.c by using
> already available wait_for_event_{un}interruptible_{timeout},
> prepare_wait, finish_wait etc calls. What do you say?

Yes, it is;) I already have it and I will try to get them back.

BTW, for memset, I thought that the residual code is in the one in
"dsp_taskmod_init()", isn't it?

    Hiroshi DOYU
