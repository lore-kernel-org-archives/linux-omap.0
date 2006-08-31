From: "Abot Botbot" <dejanigma@hotmail.com>
Subject: Debug Output
Date: Thu, 31 Aug 2006 14:10:15 +0000
Message-ID: <BAY102-F183AEDAADCC650D4263969A93F0@phx.gbl>
References: <20060831033746.25882.qmail@web17810.mail.tpe.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060831033746.25882.qmail@web17810.mail.tpe.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello all,


    I'm trying to edit the RF6 refference framework application to suit m=
y=20
purposes. At the moment I want to get a feel for how many samples go thro=
ugh=20
their filter with each message from the GPP. My algorithm works on a samp=
le=20
by sample basis, so I'm guessing I want to do my loop multiple times per=20
message from the GPP. My questions is, how can I output basic debug mater=
ial=20
to the console? Can I just throw printf statements in any place in the co=
de=20
and see the output in the console? I see statments like "UTL_logDebug(=20
"Application started." );" etc, where does that output end up?

Thanks,
Andy

_________________________________________________________________
Windows Live Spaces is here! It=92s easy to create your own personal Web =
site.=20
  http://spaces.live.com/signup.aspx
