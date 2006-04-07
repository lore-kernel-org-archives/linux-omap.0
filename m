From: "prafulla chandra vejendla" <v.prafulla@gmail.com>
Subject: debug unresolved in the tokliBIOS.lib while generating binary for
	the 55xx using the codegen toll
Date: Fri, 7 Apr 2006 10:26:55 +0530
Message-ID: <26d3a31c0604062156sffdb4fbu56797b3987ab035@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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
i am using the DSP GATEWAY to communicate between the ARM and DSP processor=
.
i am using the gateway version 3.1 for my linux 2.6.11.3
i have generated the tokliBIOS.lib using the ccs version 3.1 . this
generated library i am using in the make file for generating the user binar=
y
executables. but i got error message like "*debug unresolved in the
tokliBIOS.lib*".
why it is comming ?? is there any relation between the error and the ccs
version.??
in the tokliBIOS.lib generation pdf procedure is mentioned for the ccs
version 2.20. what could be the changes that i need to made to generate the
same tokliBIOS.lib using the ccs version 3.1 .
what could be the problem??
thanks in advance
--prafulla chandra
