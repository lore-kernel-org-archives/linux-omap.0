From: Ran Shalit <ranshalit@gmail.com>
Subject: cpuidle vs suspend/resume
Date: Tue, 14 Oct 2014 20:23:52 +0300
Message-ID: <CAJ2oMh+VX+ENiHxGkyeYwHkekSH-JzNOJPZS7bdvxZEo5UZ4sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello,

I am trying to understand the relation between HW PWM, and the linux
mechanism (cpuidle and suspend/resume). If you are familiar with the
relations between the 2 I wil appreciate your comments.

For example, are the wakeup source relevant for changing the cpu state
or do they trigger change only if suspend/resume mechanism is used ?
Is the c-state (which is changed by the cpuidle mechanism) relevant
for the state of the cpu only (without the peripheral devices) ?

Thanks,
Ran
