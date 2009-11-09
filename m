From: "Dasgupta, Romit" <romit@ti.com>
Subject: Re: [PATCH 1/1] PM: Thaws refrigerated and to be exited
 kernel threads
Date: Mon, 9 Nov 2009 14:48:09 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE3B67A0@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE31F934@dbde02.ent.ti.com>
	<20091107165421.GA1630@ucw.cz>
	<B85A65D85D7EB246BE421B3FB0FBB59301DE31FCF1@dbde02.ent.ti.com>
	<20091108082727.GC16482@elf.ucw.cz>
	<B85A65D85D7EB246BE421B3FB0FBB59301DE31FD10@dbde02.ent.ti.com>
	<20091109083133.GB4818@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091109083133.GB4818@elf.ucw.cz>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> Really? I believe the "ktrhead_should_stop" is new rule, and code does
> not seem to follow it. Actually, for example audit does not seem to
> use kthread_should_stop() at all...
> 
> ./kernel/rtmutex-tester.c-
> ./kernel/rtmutex-tester.c-		/* Wait for the next 
> command to be executed */
> ./kernel/rtmutex-tester.c-		schedule();
> ./kernel/rtmutex-tester.c:		try_to_freeze();
> ./kernel/rtmutex-tester.c-
> ./kernel/rtmutex-tester.c-		if (signal_pending(current))
> ./kernel/rtmutex-tester.c-			flush_signals(current);
> --
Not a new rule. For these threads you listed no one stops them by sending 
'kthread_stop' so the problem does not arise! But for the threads that are 
stopped by invoking kthread_stop they do check kthread_should_stop. 
