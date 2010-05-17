From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: Issue with SCHED_FIFO app
Date: Mon, 17 May 2010 14:51:29 -0600
Message-ID: <4BF1AC51.7080108@nortel.com>
References: <k2j54a292881005092139u7e120250hf530f8b688abdd22@mail.gmail.com>	 <t2s54a292881005092142h58ccae9ch2ecec665d06a7601@mail.gmail.com>	 <AANLkTillkVE9Mmz3CiQyIF5yiZfpp13g18UCyMQSuZ_K@mail.gmail.com>	 <201005131249.56432.kernel@kolivas.org> <AANLkTilGJ8VVFM5sUEP3ZXOSaUSeGpxui7NkuUPRpM_m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTilGJ8VVFM5sUEP3ZXOSaUSeGpxui7NkuUPRpM_m@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xianghua Xiao <xiaoxianghua@gmail.com>
Cc: Con Kolivas <kernel@kolivas.org>, Suresh Rajashekara <suresh.raj+linuxomap@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/12/2010 09:16 PM, Xianghua Xiao wrote:

> I'm unsure if the newest "top" (or /proc/PID/stat) reports the correct
> cpu usage when CFS/BFS is used, as you mentioned it seems failed to do
> that. I will try to stress the system and see who fails first under
> same workload, maybe that's the only way to compare cpu usage between
> 2.6.18rt vs 2.6.33rt, for now.

If you turn on scheduler debugging, then /proc/sched_debug gives
accurate information using the scheduler clock (at least with CFS, not
sure about BFS).

Chris
