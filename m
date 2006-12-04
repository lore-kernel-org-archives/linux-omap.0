From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: memset in dsp_task_config_all
Date: Mon, 04 Dec 2006 09:33:07 +0200 (EET)
Message-ID: <20061204.093307.34153114.Hiroshi.DOYU@nokia.com>
References: <3a5b1be00612031024m30ae1e10i2206d1d8e2259544@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3a5b1be00612031024m30ae1e10i2206d1d8e2259544@mail.gmail.com>
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

Komal,

From: "ext Komal Shah" <komal.shah802003@gmail.com>
Subject: memset in dsp_task_config_all
Date: Sun, 3 Dec 2006 23:55:00 +0530

> Doyu-San,
> 
> Why memset is being called again on dsptask and taskdevices  in
> dsp_task_config_all function, which was already done while we
> initialized the module (dsp_taskmod_init())?

They seem to be residual. The one which is called in
"dsp_taskmod_init()" can be omitted.

> Also why we are not preferring linked list based approach for
> maintaining dsp tasks instead of static array of max 255 dsp tasks and
> equal no of taskdevices?
> 
> On a real device, I don't see more 10-15 tasks/algorithms running on
> dsp.

Fair enough, at least, to me.
Toshihiro-san, do you have any comments?

     Hiroshi DOYU
