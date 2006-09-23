From: srini kode <srinikode@yahoo.com>
Subject: running user application on omap
Date: Sat, 23 Sep 2006 13:38:05 -0700 (PDT)
Message-ID: <20060923203805.67306.qmail@web54309.mail.yahoo.com>
References: <EA12F909C0431D458B9D18A176BEE4A507B537A2@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A507B537A2@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

We are writing a test user application to run in user
space. We downloaded the gcc from linux.omap.com site,
installed it under /usr/linux/arm
and compiled successfully the application as follows:

arm-linux-gcc-3.3.2 -I /usr/local/arm/3.3.2/include -L
/usr/local/arm/3.3.2/lib apptest.c -o apptest

Now we created a test directory on the nfs mounted
root directory in omap 2430 sdp and copied the
"apptest" to this directory and executed from there.
We get the follwoing error:

/test $ ./apptest
-sh: ./apptest: not found
/test $

All the above we were trying from the
console(hyperterminal connected to uart1-2 on omap).

can you please let us know the steps we are missing.

Regards
Srini





__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
