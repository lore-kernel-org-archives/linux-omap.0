From: Ashok Babu <ashok3d@gmail.com>
Subject: Self modifying code in ARM 11 architectures
Date: Tue, 24 May 2011 15:45:41 +0530
Message-ID: <BANLkTi=mVsYiubqtJO2BmWvExMvUFRg6dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3737431330946516442=="
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
List-Unsubscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Sender: kernelnewbies-bounces@kernelnewbies.org
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: linux-omap@vger.kernel.org, Kernelnewbies@kernelnewbies.org
List-Id: linux-omap@vger.kernel.org

--===============3737431330946516442==
Content-Type: multipart/alternative; boundary=0016e6d260a8cef1d904a402dee1

--0016e6d260a8cef1d904a402dee1
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

I am no success in booting up the ARM1176 processor with the linux-2.6.32
kernel.

While googling about the ARM Harvard architecture, I came to know that we
have to flush/invalidate the D-Cache and I-Cache
when using the self modifying codes.

So here my questions/doubts :
1) Is'nt it the kernel itself is self modifying code with lots of function
pointers ?
    If yes, how is synchronization b/w d-cache and i-cache handled in the
kernel ?
2) Can this be the reason for the kernel not booting for me ?
    Because If i disable the I-Cache in the config, then the kernel boots up
without any issues.

Any pointers on this will be of great help.

Thanks & Best Regards
Ashok

--0016e6d260a8cef1d904a402dee1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,<div><br></div><div>I am no success in booting up the ARM1176 proces=
sor with the linux-2.6.32 kernel.</div><div><br></div><div>While googling a=
bout the ARM=A0Harvard=A0architecture, I came to know that we have to flush=
/invalidate the D-Cache and I-Cache=A0</div>
<div>when using the self modifying codes.</div><div><br></div><div>So here =
my questions/doubts :</div><div>1) Is&#39;nt it the kernel itself is self m=
odifying code with lots of function pointers ?</div><div>=A0 =A0 If yes, ho=
w is synchronization b/w d-cache and i-cache handled in the kernel ?</div>
<div>2) Can this be the reason for the kernel not booting for me ?</div><di=
v>=A0 =A0 Because If i disable the I-Cache in the config, then the kernel b=
oots up without any issues.</div><div><br></div><div>Any pointers on this w=
ill be of great help.</div>
<div><br></div><div>Thanks &amp; Best Regards</div><div>Ashok</div><div>=A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0<br><div><br></div><div>=
<br></div></div>

--0016e6d260a8cef1d904a402dee1--


--===============3737431330946516442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--===============3737431330946516442==--
