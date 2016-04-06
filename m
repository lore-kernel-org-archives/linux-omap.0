From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 3/4] mailbox/omap: remove FSF mailing address paragraph
Date: Wed, 6 Apr 2016 12:37:39 -0500
Message-ID: <1459964260-43054-4-git-send-email-s-anna@ti.com>
References: <1459964260-43054-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459964260-43054-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Remove the paragraph about writing to the Free Software
Foundation's mailing address from the GPL license header
as this address can change. This fixes the corresponding
checkpatch warning.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 274db62ccbbe..3ffdc7dbb09e 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -15,12 +15,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
  */
 
 #include <linux/interrupt.h>
-- 
2.7.4
