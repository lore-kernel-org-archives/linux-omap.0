From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH omap v2 0/6] Fix OMAP uses of RCU from idle loop
Date: Wed, 18 May 2016 07:38:39 -0700
Message-ID: <573C7E6F.90001@roeck-us.net>
References: <20160516184844.GA20144@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160516184844.GA20144@linux.vnet.ibm.com>
Sender: linux-clk-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org
Cc: tony@atomide.com, mingo@kernel.org, rostedt@goodmis.org
List-Id: linux-omap@vger.kernel.org

On 05/16/2016 11:48 AM, Paul E. McKenney wrote:
> Hello!
>
> The following series fixes a number of uses of RCU from the idle loop.
> These are all due to tracing, so the fix is simply to append _rcuidle
> to the event-tracing call.
>
> Changes since v1: Fix commit-log subjects and add maintainers on CC.
>

For the series, on top of mainline (which now experiences the problem fixed
by this series):

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

