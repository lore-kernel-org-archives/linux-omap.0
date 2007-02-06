From: Arnold <abo_gwapo@yahoo.com>
Subject: Flash read/write
Date: Tue, 6 Feb 2007 00:41:10 -0800 (PST)
Message-ID: <229468.21740.qm@web55311.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All,

I am having problems writing a file to the flash. I am
using omap5912 and kernel2.6.17. I have 2 problems
here. First, when I create a file(which does not
exist) using the standard linux open the return value
is always -1 which I think is an error. However, when
the file is existing, I can write succesfully. So what
I did is create a tmpFile with zero bytes then include
it in my filesystem, then use the cp to create the
file that I can use. Is this a problem on the
permission on jffs2 filesystem? The second problem is
the speed in writing to the flash. If I write to the
flash for the first time it is taking so long to
finish compared to the second time I write to the
flash. Could someone enlighten me?

Thanks,
Arnold


 
____________________________________________________________________________________
Any questions? Get answers on any topic at www.Answers.yahoo.com.  Try it now.
