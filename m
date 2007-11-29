From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 0/1] ARM: OMAP: Fix Siemens SX1 building failure
Date: Thu, 29 Nov 2007 11:14:01 -0400
Message-ID: <474ED739.8060103@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

During SX1 building, I got the following error:

...
  CC      sound/arm/omap/omap-alsa-sx1.o
sound/arm/omap/omap-alsa-sx1.c:32: error: 'CN_IDX_SX1SND' undeclared
here (not in a function)
sound/arm/omap/omap-alsa-sx1.c:32: error: 'CN_VAL_SX1SND' undeclared
here (not in a function)
make[3]: *** [sound/arm/omap/omap-alsa-sx1.o] Error 1
make[2]: *** [sound/arm/omap] Error 2
make[1]: *** [sound/arm] Error 2
make: *** [sound] Error 2

Well, I'm proposing this patch that redefines CN_IDX_SX1SND and
CN_VAL_SX1SND macros at include/linux/connector.h. It's based on Komal
Shah' earlier patch [1].

In fact, I was searching on connector.h' file history at Linux-OMAP tree
[2] for the commit that removed such macros and I couldn't find it. Very
strange!

BR,

Carlos.

[1]
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=f5403be5ff2ba15c709f479809a0101f64fe0f01
[2]
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=history;f=include/linux/connector.h;h=13fc4541bf235b14333920f35e7ac744c5085bc9;hb=HEAD

-- 
Carlos Eduardo Aguiar
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC - Manaus
Core Team
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
