From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] Two wakeirq fixes
Date: Fri, 10 Feb 2017 23:33:56 +0100
Message-ID: <CAJZ5v0jLxDd4binnh8XnXe8Jpk5h_oFFZiR=mv18H1fhuneGvQ@mail.gmail.com>
References: <20170210222501.7948-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170210222501.7948-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 10, 2017 at 11:24 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi all,
>
> Here are two wakeirq fixes from Grygorii that have been pending for
> a while.
>
> Earlier before commit bed570307ed7 ("PM / wakeirq: Fix dedicated
> wakeirq for drivers not using autosuspend") I did not see changes
> with my test cases with these two changes, but now I have test cases
> that get fixed with these two patches.

OK, I'll queue them up.

If a new merge window starts on Sunday, however, they will not make it
to my first pull request.  I'll push them in the second half of the
merge window in that case.

Thanks,
Rafael
