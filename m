From: Orjan Friberg <of@flatfrog.com>
Subject: Re: CONFIG_PREEMPT and JFFS2 oops
Date: Wed, 25 Jan 2012 22:02:06 +0100
Message-ID: <4F206DCE.3060609@flatfrog.com>
References: <4F206213.9070704@flatfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:46230
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752538Ab2AYVCJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jan 2012 16:02:09 -0500
In-Reply-To: <4F206213.9070704@flatfrog.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 01/25/2012 09:12 PM, Orjan Friberg wrote:
> I've boiled it down to whether CONFIG_PREEMPT (bug happens) or
> CONFIG_PREEMPT_VOLUNTARY (bug doesn't happen) is selected.

No, I haven't.  The problem disappeared only for

    while :; do dd if=/dev/zero of=file bs=800 count=1; done

That one-liner was boiled down from the following program, which still
oopses instantly:

    #include <stdio.h>
    #include <unistd.h>
    #include <sys/types.h>
    #include <sys/stat.h>
    #include <fcntl.h>

    int main()
    {
      int fd;
      struct stat st;
      char buf[800];

      do {
        unlink("file2");
        fd = open("file1", O_RDWR|O_CREAT|O_TRUNC, 0666);
        stat("file1", &st);
        lseek(fd, 0, SEEK_SET);
        write(fd, buf, 800);
        close(fd);
        rename("file1", "file2");
      } while (1);

      return 0;
    }


(Apologies for spamming.)


-- 
Orjan Friberg
FlatFrog Laboratories AB
