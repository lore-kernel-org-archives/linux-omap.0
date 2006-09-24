From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: running user application on omap
Date: Sun, 24 Sep 2006 10:07:56 -0500
Message-ID: <45169F4C.2050407@gmail.com>
References: <20060923203805.67306.qmail@web54309.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060923203805.67306.qmail@web54309.mail.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: srini kode <srinikode@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

srini kode stated on 9/23/2006 3:38 PM:
> /test $ ./apptest
> -sh: ./apptest: not found
> /test $
Looks like a problem when:
1.The application and the filesystem are compiled using two different
compilers.
2. some required libraries are not present in ur filesystem.

Soln: build your own filesystem and app:
codesourcery gives u the compilers, busybox gives u the filesystem. or u
can even recompile the ti.com/pub provided source code.

happy hunting..
Regards,
Nishanth Menon
