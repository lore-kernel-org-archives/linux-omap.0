From: "Michal Szabat" <michal611@interia.pl>
Subject: Re: error in 2.6.8-rc3_080804 make
Date: Tue, 28 Feb 2006 19:47:29 +0100
Message-ID: <000f01c63c97$754ce620$0301a8c0@hydra>
References: <26d3a31c0602280729p122f8d4ble60d7d450642b004@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="ISO-8859-1";
	reply-type=original
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
To: prafulla chandra vejendla <v.prafulla@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


>----- Original Message ----- 
From: "prafulla chandra vejendla" <v.prafulla@gmail.com>
To: <linux-omap-open-source@linux.omap.com>
Sent: Tuesday, February 28, 2006 4:29 PM
Subject: error in 2.6.8-rc3_080804 make


Hi all,
i am using linux 2.6.8-rc3_080804.tar with out any patch  to build kernal
for my osk5912 board. i am following accarding to the newbie guide pdf for
omap5912 . we are using gcc 3.4.1 . while i am doing the following steps.
along with this steps i am attaching the error and the config file .am i
missing any step.kindly guide

make clean
make omap_osk_5912_defconfig
make menuconfig
make

now i am getting error as cc1 error invalid option 'short-load-byters'
make[2]: ***[scripts/mod/empty.o]  Error 1
make[1]:***[scripts/mod] Error 2
make:*** [scripts] Errpr 2
/
/
I remowed this option from some file (probably ~/scripts/mod/empty.o but i,m 
not sure, and i don't have this source at the moment) 


------------------------------------------------------------
Taaaaaaakie auto! >>> http://link.interia.pl/f1910
