From: "Sergey Vointsev" <vointsev@gmail.com>
Subject: Re: "File not found" error while loading dspgateway demo
Date: Thu, 27 Apr 2006 17:58:30 +0400
Message-ID: <9713be7f0604270658p5270b8f5xdda32a03fb7a3a7f@mail.gmail.com>
References: <9713be7f0604250418t4cb184efke0bc07f88846b66@mail.gmail.com>
	<003601c6686c$7f004a80$0301a8c0@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <003601c6686c$7f004a80$0301a8c0@hydra>
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thanks, Hiroshi and Michal!
Trick with
mknod /dev/dsptask/demo_console c 97 0
worked fine :)

Sergey.
--
Also available for instant messaging via Google Talk.
Need invite to Gmail? I have one for you! Just ask.
