From: saminath sanjay <saminathmail@yahoo.com>
Subject: GCC-4.0.2 Error on TI-OMAP 1510
Date: Tue, 9 May 2006 22:54:39 -0700 (PDT)
Message-ID: <20060510055439.45105.qmail@web31813.mail.mud.yahoo.com>
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

Dear All,
   
  Currently I am working TI-OMAP 1510 Innovator Developement Board,
  I am Using Linux-2.4.19 Kernel with GCC-2.95.2 . Is working fine. But it does not support X windows platform. Now we plan to go for Higher version of Kernel 2.6.14 with GCC-4.0.2. I am facing the following errors when i build the cross compiling tool chain
   
  Host Machine is Red-Hat 9.0
   
  /opt/arm-linux/arm-linux/bin/ld: crti.o: No such file: No such file or directory
collect2: ld returned 1 exit status
make[2]: *** [libgcc_s.so] Error 1
make[2]: Leaving directory `/usr/src/arm-linux/build/gcc-4.0.2/gcc'
make[1]: *** [libgcc.a] Error 2
make[1]: Leaving directory `/usr/src/arm-linux/build/gcc-4.0.2/gcc'
make: *** [all-gcc] Error 2
   
  any one give the solution to solve the above problem
   
  thanks and regards
  Saminath


 __________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
