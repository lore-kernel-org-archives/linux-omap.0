From: Francisco Alecrim <francisco.alecrim@indt.org.br>
Subject: OMAP H3: compile error SEGMENT_SIZE undeclared
Date: Mon, 05 Nov 2007 16:27:19 -0400
Message-ID: <472F7CA7.5040903@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi all,

    I'm trying to compile OMAP H3 default 
configuration(omap_h3_1710_defconfig), but the error below happens.


...
fs/binfmt_aout.c: In function `load_aout_binary':
fs/binfmt_aout.c:316: error: `SEGMENT_SIZE' undeclared (first use in 
this function)
fs/binfmt_aout.c:316: error: (Each undeclared identifier is reported 
only once
fs/binfmt_aout.c:316: error: for each function it appears in.)
...

Any idea?

-- 
Francisco Keppler Silva Alecrim 
INdT - OSMRC - Manaus
Core team 

Tel   : (+55 92) 2126 1017	
Mobile: (+55 92) 8803 5462	
Skype : keppleralecrim
Jabber: alecrim@gmail.com
