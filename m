From: Tony Lindgren <tony@atomide.com>
Subject: Re: droid 4 in v4.18-rc: grep -r adasfasd /sys/ oopses
Date: Mon, 9 Jul 2018 03:33:05 -0700
Message-ID: <20180709103305.GF112168@atomide.com>
References: <20180708174939.GA10002@amd>
 <20180708193720.GA13262@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180708193720.GA13262@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-pm mailing list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180708 19:40]:
> Ok, so it seems to be:
> 
> user@devuan:~$ cat /sys/kernel/debug/pm_debug/count
> (oops).
> 
> The file seems to be world-readable.
> 
> user@devuan:~$ ls -al /sys/kernel/debug/pm_debug/count
> -r--r--r-- 1 root root 0 Jan  1  1970 /sys/kernel/debug/pm_debug/count
> 
> But on PC, that file does not exist.
> 
> Any ideas?

I'm not seeing this as tested with omap2plus_defconfig and
not seeing any unclocked module interrupts here.. Can you
see if the script below produces something for you?

I had to filter out some trace pipes as they seem to hang.

Regards,

Tony

8< -----
#!/bin/sh

files=$(find /sys -type f)

for file in ${files}; do
        if echo ${file} | grep -e trace_pipe -e stats; then
                echo "Skipping ${file}.."
                continue
        fi
        echo "Grepping in ${file}.."
        grep asdf ${file}
done
