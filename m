From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Recent git kernels and OSK
Date: Wed, 04 Oct 2006 15:27:48 +0200
Message-ID: <4523B6D4.1070305@gmail.com>
References: <4521941B.2020102@balister.org> <45226BC5.9050201@gmail.com>
	<452280A5.5080805@gmail.com> <452378FA.9050604@gmail.com>
	<4523892B.3000505@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4523892B.3000505@balister.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Philip Balister <philip@balister.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Philip Balister wrote:
> Do you mind sending me the sequence you use to prepare the kernel for 
> flashing? I  have lost confidence in myself ... 

For testing I use uboot TFTP download.

> I can't get anything to 
> boot. What is the most recent kernel you have booted on the OSK?

Going back to "ARM: OMAP: DSPGW: mailbox log cleanup" [1] 
results in a kernel which works for me on OSK. If you have 
most recent git, try

cg-admin-uncommit -t 4b35036f09f89dcc25b0a770c56e2c71d4937cb4

to go back to this version.

Regards

Dirk

[1] 
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=0992816784c16d294b884c15fde6fe469a18a01f
